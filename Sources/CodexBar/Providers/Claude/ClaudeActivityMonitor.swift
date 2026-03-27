import CoreServices
import Foundation
import os.lock

/// Monitors Claude's local JSONL project files for write activity using FSEventStream.
/// The callback sets an atomic flag that the timer loop reads and resets on each tick.
final class ClaudeActivityMonitor: @unchecked Sendable {
    private let _activityDetected = OSAllocatedUnfairLock(initialState: false)
    private var stream: FSEventStreamRef?
    private let queue = DispatchQueue(label: "com.codexbar.claude-activity-monitor", qos: .utility)

    /// Returns `true` if file activity was detected since the last `consumeActivity()` call.
    var activityDetected: Bool {
        self._activityDetected.withLock { $0 }
    }

    /// Atomically reads and resets the activity flag.
    func consumeActivity() -> Bool {
        self._activityDetected.withLock { value in
            let was = value
            value = false
            return was
        }
    }

    /// Starts monitoring the given directory paths recursively for file changes.
    func start(paths: [String]) {
        guard self.stream == nil, !paths.isEmpty else { return }

        let existingPaths = paths.filter { FileManager.default.fileExists(atPath: $0) }
        guard !existingPaths.isEmpty else { return }

        var context = FSEventStreamContext()
        context.info = Unmanaged.passUnretained(self).toOpaque()

        guard let newStream = FSEventStreamCreate(
            nil,
            ClaudeActivityMonitor.fsEventCallback,
            &context,
            existingPaths as CFArray,
            FSEventStreamEventId(kFSEventStreamEventIdSinceNow),
            1.0,
            FSEventStreamCreateFlags(kFSEventStreamCreateFlagFileEvents | kFSEventStreamCreateFlagUseCFTypes))
        else { return }

        self.stream = newStream
        FSEventStreamSetDispatchQueue(newStream, self.queue)
        FSEventStreamStart(newStream)
    }

    /// Stops monitoring and releases the stream.
    func stop() {
        guard let stream = self.stream else { return }
        FSEventStreamStop(stream)
        FSEventStreamInvalidate(stream)
        FSEventStreamRelease(stream)
        self.stream = nil
    }

    deinit {
        self.stop()
    }

    // MARK: - Claude projects root resolution

    /// Returns the default Claude projects root directories to monitor.
    static func claudeProjectsRoots() -> [URL] {
        if let env = ProcessInfo.processInfo.environment["CLAUDE_CONFIG_DIR"]?
            .trimmingCharacters(in: .whitespacesAndNewlines),
            !env.isEmpty
        {
            var roots: [URL] = []
            for part in env.split(separator: ",") {
                let raw = String(part).trimmingCharacters(in: .whitespacesAndNewlines)
                guard !raw.isEmpty else { continue }
                let url = URL(fileURLWithPath: raw)
                if url.lastPathComponent == "projects" {
                    roots.append(url)
                } else {
                    roots.append(url.appendingPathComponent("projects", isDirectory: true))
                }
            }
            return roots
        }

        let home = FileManager.default.homeDirectoryForCurrentUser
        return [
            home.appendingPathComponent(".config/claude/projects", isDirectory: true),
            home.appendingPathComponent(".claude/projects", isDirectory: true),
        ]
    }

    // MARK: - FSEventStream callback

    // swiftlint:disable:next closure_parameter_position
    private static let fsEventCallback: FSEventStreamCallback = { _, info, _, _, _, _ in
        guard let info else { return }
        let monitor = Unmanaged<ClaudeActivityMonitor>.fromOpaque(info).takeUnretainedValue()
        monitor._activityDetected.withLock { $0 = true }
    }
}

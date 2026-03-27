import CodexBarCore
import KeyboardShortcuts
import SwiftUI

@MainActor
struct AdvancedPane: View {
    @Bindable var settings: SettingsStore
    @State private var isInstallingCLI = false
    @State private var cliStatus: String?

    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 16) {
                SettingsSection(contentSpacing: 8) {
                    Text(L10n.sectionKeyboardShortcut)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .textCase(.uppercase)
                    HStack(alignment: .center, spacing: 12) {
                        Text(L10n.openMenu)
                            .font(.body)
                        Spacer()
                        KeyboardShortcuts.Recorder(for: .openMenu)
                    }
                    Text(L10n.openMenuSubtitle)
                        .font(.footnote)
                        .foregroundStyle(.tertiary)
                }

                Divider()

                SettingsSection(contentSpacing: 10) {
                    HStack(spacing: 12) {
                        Button {
                            Task { await self.installCLI() }
                        } label: {
                            if self.isInstallingCLI {
                                ProgressView().controlSize(.small)
                            } else {
                                Text(L10n.installCLI)
                            }
                        }
                        .disabled(self.isInstallingCLI)

                        if let status = self.cliStatus {
                            Text(status)
                                .font(.footnote)
                                .foregroundStyle(.tertiary)
                                .lineLimit(2)
                        }
                    }
                    Text(L10n.installCLISubtitle)
                        .font(.footnote)
                        .foregroundStyle(.tertiary)
                }

                Divider()

                SettingsSection(contentSpacing: 10) {
                    PreferenceToggleRow(
                        title: L10n.showDebugSettings,
                        subtitle: L10n.showDebugSettingsSubtitle,
                        binding: self.$settings.debugMenuEnabled)
                    PreferenceToggleRow(
                        title: L10n.surpriseMe,
                        subtitle: L10n.surpriseMeSubtitle,
                        binding: self.$settings.randomBlinkEnabled)
                }

                Divider()

                SettingsSection(contentSpacing: 10) {
                    PreferenceToggleRow(
                        title: L10n.hidePersonalInfo,
                        subtitle: L10n.hidePersonalInfoSubtitle,
                        binding: self.$settings.hidePersonalInfo)
                }

                Divider()

                SettingsSection(
                    title: L10n.sectionKeychainAccess,
                    caption: L10n.keychainAccessCaption) {
                        PreferenceToggleRow(
                            title: L10n.disableKeychainAccess,
                            subtitle: L10n.disableKeychainAccessSubtitle,
                            binding: self.$settings.debugDisableKeychainAccess)
                    }

                Divider()

                SettingsSection(
                    title: L10n.sectionHTTPProxy,
                    caption: L10n.httpProxyCaption)
                {
                    PreferenceToggleRow(
                        title: L10n.enableProxy,
                        subtitle: L10n.enableProxySubtitle,
                        binding: self.$settings.proxyEnabled)

                    if self.settings.proxyEnabled {
                        Picker("Type", selection: self.$settings.proxyType) {
                            ForEach(ProxyType.allCases, id: \.self) { type in
                                Text(type.label).tag(type)
                            }
                        }
                        .pickerStyle(.segmented)

                        HStack(spacing: 8) {
                            TextField(L10n.proxyHost, text: self.$settings.proxyHost)
                                .textFieldStyle(.roundedBorder)
                            TextField(
                                L10n.proxyPort,
                                value: self.$settings.proxyPort,
                                format: .number.grouping(.never))
                                .textFieldStyle(.roundedBorder)
                                .frame(width: 80)
                        }

                        TextField(L10n.proxyUsername, text: self.$settings.proxyUsername)
                            .textFieldStyle(.roundedBorder)
                        SecureField(L10n.proxyPassword, text: self.$settings.proxyPassword)
                            .textFieldStyle(.roundedBorder)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
        }
    }
}

extension AdvancedPane {
    private func installCLI() async {
        if self.isInstallingCLI { return }
        self.isInstallingCLI = true
        defer { self.isInstallingCLI = false }

        let helperURL = Bundle.main.bundleURL.appendingPathComponent("Contents/Helpers/CodexBarCLI")
        let fm = FileManager.default
        guard fm.fileExists(atPath: helperURL.path) else {
            self.cliStatus = L10n.cliNotFound
            return
        }

        let destinations = [
            "/usr/local/bin/codexbar",
            "/opt/homebrew/bin/codexbar",
        ]

        var results: [String] = []
        for dest in destinations {
            let dir = (dest as NSString).deletingLastPathComponent
            guard fm.fileExists(atPath: dir) else { continue }
            guard fm.isWritableFile(atPath: dir) else {
                results.append("No write access: \(dir)")
                continue
            }

            if fm.fileExists(atPath: dest) {
                if Self.isLink(atPath: dest, pointingTo: helperURL.path) {
                    results.append("Installed: \(dir)")
                } else {
                    results.append("Exists: \(dir)")
                }
                continue
            }

            do {
                try fm.createSymbolicLink(atPath: dest, withDestinationPath: helperURL.path)
                results.append("Installed: \(dir)")
            } catch {
                results.append("Failed: \(dir)")
            }
        }

        self.cliStatus = results.isEmpty
            ? L10n.cliNoBinDirs
            : results.joined(separator: " · ")
    }

    private static func isLink(atPath path: String, pointingTo destination: String) -> Bool {
        guard let link = try? FileManager.default.destinationOfSymbolicLink(atPath: path) else { return false }
        let dir = (path as NSString).deletingLastPathComponent
        let resolved = URL(fileURLWithPath: link, relativeTo: URL(fileURLWithPath: dir))
            .standardizedFileURL
            .path
        return resolved == destination
    }
}

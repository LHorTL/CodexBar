import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Centralized URLSession provider that supports proxy configuration.
///
/// All network-fetching code in CodexBarCore should use `NetworkSession.shared` instead of
/// `URLSession.shared`. The app layer configures proxy settings via `NetworkSession.configure(proxy:)`.
public enum NetworkSession {
    private static let lock = NSLock()
    nonisolated(unsafe) private static var _session: URLSession = .shared
    nonisolated(unsafe) private static var _configuration: ProxyConfiguration?
    /// Track the non-.shared session so we can invalidate it on reconfigure.
    nonisolated(unsafe) private static var _customSession: URLSession?

    /// The URLSession all providers should use instead of `URLSession.shared`.
    public static var shared: URLSession {
        self.lock.withLock { self._session }
    }

    /// Applies the current proxy settings to the given configuration.
    /// Use this for providers that create custom `URLSession` instances (e.g. with delegates).
    public static func applyProxy(to config: URLSessionConfiguration) -> URLSessionConfiguration {
        self.lock.withLock {
            guard let proxy = self._configuration, proxy.enabled, !proxy.host.isEmpty else { return config }
            config.connectionProxyDictionary = Self.proxyDictionary(from: proxy)
            return config
        }
    }

    /// Called from the app layer when proxy settings change or at launch.
    public static func configure(proxy: ProxyConfiguration?) {
        self.lock.withLock {
            self._configuration = proxy
            let oldCustom = self._customSession

            if let proxy, proxy.enabled, !proxy.host.isEmpty {
                let config = URLSessionConfiguration.default
                config.connectionProxyDictionary = Self.proxyDictionary(from: proxy)
                let newSession = URLSession(configuration: config)
                self._session = newSession
                self._customSession = newSession
            } else {
                self._session = .shared
                self._customSession = nil
            }

            oldCustom?.finishTasksAndInvalidate()
        }
    }

    private static func proxyDictionary(from proxy: ProxyConfiguration) -> [String: Any] {
        var dict: [String: Any] = [:]

        #if os(macOS) || os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
        switch proxy.type {
        case .http:
            // HTTP proxy — also route HTTPS through it
            dict[kCFNetworkProxiesHTTPEnable as String] = true
            dict[kCFNetworkProxiesHTTPProxy as String] = proxy.host
            dict[kCFNetworkProxiesHTTPPort as String] = proxy.port
            dict[kCFNetworkProxiesHTTPSEnable as String] = true
            dict[kCFNetworkProxiesHTTPSProxy as String] = proxy.host
            dict[kCFNetworkProxiesHTTPSPort as String] = proxy.port

        case .https:
            dict[kCFNetworkProxiesHTTPEnable as String] = true
            dict[kCFNetworkProxiesHTTPProxy as String] = proxy.host
            dict[kCFNetworkProxiesHTTPPort as String] = proxy.port
            dict[kCFNetworkProxiesHTTPSEnable as String] = true
            dict[kCFNetworkProxiesHTTPSProxy as String] = proxy.host
            dict[kCFNetworkProxiesHTTPSPort as String] = proxy.port

        case .socks5:
            dict[kCFStreamPropertySOCKSProxyHost as String] = proxy.host
            dict[kCFStreamPropertySOCKSProxyPort as String] = proxy.port
            dict[kCFStreamPropertySOCKSVersion as String] = kCFStreamSocketSOCKSVersion5
        }

        // Authentication
        if let username = proxy.username, !username.isEmpty {
            if proxy.type == .socks5 {
                dict[kCFStreamPropertySOCKSUser as String] = username
                dict[kCFStreamPropertySOCKSPassword as String] = proxy.password ?? ""
            } else {
                dict[kCFProxyUsernameKey as String] = username
                dict[kCFProxyPasswordKey as String] = proxy.password ?? ""
            }
        }
        #else
        // Linux: use string keys directly (CFNetwork constants are not available)
        switch proxy.type {
        case .http, .https:
            dict["HTTPEnable"] = true
            dict["HTTPProxy"] = proxy.host
            dict["HTTPPort"] = proxy.port
            dict["HTTPSEnable"] = true
            dict["HTTPSProxy"] = proxy.host
            dict["HTTPSPort"] = proxy.port

        case .socks5:
            dict["SOCKSProxy"] = proxy.host
            dict["SOCKSPort"] = proxy.port
        }

        if let username = proxy.username, !username.isEmpty {
            if proxy.type == .socks5 {
                dict["SOCKSUser"] = username
                dict["SOCKSPassword"] = proxy.password ?? ""
            } else {
                dict["HTTPProxyUsername"] = username
                dict["HTTPProxyPassword"] = proxy.password ?? ""
            }
        }
        #endif

        return dict
    }
}

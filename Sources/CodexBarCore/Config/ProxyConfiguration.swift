import Foundation

public enum ProxyType: String, CaseIterable, Sendable, Codable {
    case http
    case https
    case socks5

    public var label: String {
        switch self {
        case .http: "HTTP"
        case .https: "HTTPS"
        case .socks5: "SOCKS5"
        }
    }
}

public struct ProxyConfiguration: Sendable, Codable, Equatable {
    public var enabled: Bool
    public var type: ProxyType
    public var host: String
    public var port: Int
    public var username: String?
    public var password: String?

    public init(
        enabled: Bool = false,
        type: ProxyType = .http,
        host: String = "",
        port: Int = 8080,
        username: String? = nil,
        password: String? = nil)
    {
        self.enabled = enabled
        self.type = type
        self.host = host
        self.port = port
        self.username = username
        self.password = password
    }
}

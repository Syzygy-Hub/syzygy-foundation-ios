/// An access/refresh token pair with optional expiry.
public struct AuthToken: Equatable, Codable, Sendable {
    public let accessToken: String
    public let refreshToken: String?
    public let expiresAt: SyzygyTimestamp?

    public init(accessToken: String, refreshToken: String? = nil, expiresAt: SyzygyTimestamp? = nil) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.expiresAt = expiresAt
    }

    /// True when the token has a known expiry that is in the past.
    public var isExpired: Bool {
        expiresAt.map { $0 < SyzygyTimestamp.now() } ?? false
    }
}

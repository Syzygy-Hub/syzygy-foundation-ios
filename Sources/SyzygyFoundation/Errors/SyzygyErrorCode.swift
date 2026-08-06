/// An extensible error code struct with common predefined values.
public struct SyzygyErrorCode: Equatable, Hashable, Codable, Sendable, ExpressibleByStringLiteral {
    public var rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }

    public init(stringLiteral value: String) {
        self.rawValue = value
    }

    // MARK: - Predefined codes

    public static let unknown: SyzygyErrorCode = "unknown"
    public static let cancelled: SyzygyErrorCode = "cancelled"
    public static let timeout: SyzygyErrorCode = "timeout"
    public static let unauthenticated: SyzygyErrorCode = "unauthenticated"
    public static let forbidden: SyzygyErrorCode = "forbidden"
    public static let notFound: SyzygyErrorCode = "not_found"
    public static let serverError: SyzygyErrorCode = "server_error"
    public static let networkUnavailable: SyzygyErrorCode = "network_unavailable"
    public static let decodingFailed: SyzygyErrorCode = "decoding_failed"
    public static let encodingFailed: SyzygyErrorCode = "encoding_failed"
}

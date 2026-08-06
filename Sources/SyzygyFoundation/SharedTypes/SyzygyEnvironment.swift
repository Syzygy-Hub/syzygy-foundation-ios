/// The deployment environment the app is running in.
public enum SyzygyEnvironment: String, Equatable, Codable, Sendable, CustomStringConvertible {
    case debug
    case staging
    case production

    /// True when running in the debug environment.
    public var isDebug: Bool { self == .debug }

    /// True when running in the production environment.
    public var isProduction: Bool { self == .production }

    public var description: String { rawValue }
}

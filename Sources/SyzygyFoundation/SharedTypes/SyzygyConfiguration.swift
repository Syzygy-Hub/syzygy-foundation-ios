/// Top-level application configuration contract.
public protocol SyzygyConfiguration: Sendable {
    var environment: SyzygyEnvironment { get }
    var baseURL: String { get }
    var buildInfo: SyzygyBuildInfo { get }
    var version: SyzygyVersion { get }
}

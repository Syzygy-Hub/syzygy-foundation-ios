/// Consumer-injected application metadata.
///
/// Foundation does not read from platform APIs (Bundle, UIDevice, etc.).
/// The owning application supplies all values at startup.
public struct SyzygyBuildInfo: Equatable, Codable, Sendable {
    public let appName: String
    public let bundleId: String
    public let buildNumber: String
    public let version: String

    public init(appName: String, bundleId: String, buildNumber: String, version: String) {
        self.appName = appName
        self.bundleId = bundleId
        self.buildNumber = buildNumber
        self.version = version
    }
}

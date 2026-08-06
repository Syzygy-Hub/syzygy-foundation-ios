/// A named analytics event with typed string properties and a timestamp.
///
/// Properties use `[String: String]` rather than `[String: Any]` because `Any`
/// is not `Sendable`. This is the Swift-safe approach for concurrent analytics.
public struct AnalyticsEvent: Equatable, Sendable {
    public let name: String
    public let properties: [String: String]
    public let timestamp: SyzygyTimestamp

    public init(name: String, properties: [String: String] = [:], timestamp: SyzygyTimestamp) {
        self.name = name
        self.properties = properties
        self.timestamp = timestamp
    }

    /// Convenience initialiser — timestamp defaults to now.
    public init(name: String, properties: [String: String] = [:]) {
        self.init(name: name, properties: properties, timestamp: .now())
    }
}

/// Contract for analytics tracking.
///
/// `traits` uses `[String: String]` (not `[String: Any]`) for `Sendable` compliance.
public protocol AnalyticsProvider: Sendable {
    func track(_ event: AnalyticsEvent)
    func identify(userId: String, traits: [String: String])
    func reset()
}

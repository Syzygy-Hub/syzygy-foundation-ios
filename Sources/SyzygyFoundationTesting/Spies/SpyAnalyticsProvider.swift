import SyzygyFoundation

/// A test analytics provider that records all calls.
public final class SpyAnalyticsProvider: AnalyticsProvider, @unchecked Sendable {
    public var trackedEvents: [AnalyticsEvent] = []
    public var identifiedUsers: [(userId: String, traits: [String: String])] = []
    public var resetCallCount: Int = 0

    public init() {}

    public func track(_ event: AnalyticsEvent) {
        trackedEvents.append(event)
    }

    public func identify(userId: String, traits: [String: String]) {
        identifiedUsers.append((userId: userId, traits: traits))
    }

    public func reset() {
        resetCallCount += 1
    }

    /// Returns all tracked events with the given name.
    public func events(named name: String) -> [AnalyticsEvent] {
        trackedEvents.filter { $0.name == name }
    }
}

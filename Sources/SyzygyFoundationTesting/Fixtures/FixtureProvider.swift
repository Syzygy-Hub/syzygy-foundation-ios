import Foundation
import SyzygyFoundation

/// Protocol for types that can produce a canonical fixture value for testing.
public protocol FixtureProvider {
    /// Returns a canonical fixture value suitable for use in unit tests.
    static func fixture() -> Self
}

// MARK: - SyzygyID

extension SyzygyID: FixtureProvider {
    public static func fixture() -> SyzygyID<T> {
        SyzygyID(rawValue: "fixture-id-00000000")
    }
}

// MARK: - AuthToken

extension AuthToken: FixtureProvider {
    public static func fixture() -> AuthToken {
        AuthToken(accessToken: "fixture-access-token", refreshToken: "fixture-refresh-token", expiresAt: nil)
    }
}

// MARK: - NetworkRequest

extension NetworkRequest: FixtureProvider {
    public static func fixture() -> NetworkRequest {
        NetworkRequest(url: "https://fixture.syzygy.dev/api", method: .get, headers: [:], body: nil)
    }
}

// MARK: - NetworkResponse

extension NetworkResponse: FixtureProvider {
    public static func fixture() -> NetworkResponse {
        NetworkResponse(statusCode: 200, data: Data(), headers: [:])
    }
}

// MARK: - AnalyticsEvent

extension AnalyticsEvent: FixtureProvider {
    public static func fixture() -> AnalyticsEvent {
        AnalyticsEvent(name: "test_event", properties: [:])
    }
}

// MARK: - LogEntry

extension LogEntry: FixtureProvider {
    public static func fixture() -> LogEntry {
        LogEntry(
            level: .info,
            message: "fixture log message",
            timestamp: SyzygyTimestamp(millisecondsSinceEpoch: 0),
            metadata: [:],
            error: nil
        )
    }
}

// MARK: - SyzygyVersion

extension SyzygyVersion: FixtureProvider {
    public static func fixture() -> SyzygyVersion {
        SyzygyVersion(1, 0, 0)
    }
}

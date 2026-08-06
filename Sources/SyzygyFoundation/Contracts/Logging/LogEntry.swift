/// A structured log entry.
///
/// **Equatable note:** The `error` field is intentionally excluded from the
/// `Equatable` implementation because `any Error` values are not directly
/// comparable. Two entries are considered equal when `level`, `message`,
/// `timestamp`, and `metadata` match, regardless of the attached error.
///
/// **Sendable note:** `@unchecked Sendable` is used because `(any Error)?`
/// does not conform to `Sendable`. Callers are responsible for thread-safe
/// access to the `error` value.
public struct LogEntry: @unchecked Sendable {
    public let level: LogLevel
    public let message: String
    public let timestamp: SyzygyTimestamp
    public let metadata: [String: String]
    /// Stored but excluded from Equatable. See type documentation.
    public let error: (any Error)?

    public init(
        level: LogLevel,
        message: String,
        timestamp: SyzygyTimestamp,
        metadata: [String: String] = [:],
        error: (any Error)? = nil
    ) {
        self.level = level
        self.message = message
        self.timestamp = timestamp
        self.metadata = metadata
        self.error = error
    }
}

extension LogEntry: Equatable {
    /// Compares `level`, `message`, `timestamp`, and `metadata`. The `error`
    /// field is excluded — see type documentation.
    public static func == (lhs: LogEntry, rhs: LogEntry) -> Bool {
        lhs.level == rhs.level &&
        lhs.message == rhs.message &&
        lhs.timestamp == rhs.timestamp &&
        lhs.metadata == rhs.metadata
    }
}

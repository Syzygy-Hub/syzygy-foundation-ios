import SyzygyFoundation

/// A test logger that records all log entries.
public final class MockLogger: LoggerProtocol, @unchecked Sendable {
    public var entries: [LogEntry] = []

    public init() {}

    public func log(_ entry: LogEntry) {
        entries.append(entry)
    }

    /// Returns entries filtered by log level.
    public func entries(for level: LogLevel) -> [LogEntry] {
        entries.filter { $0.level == level }
    }

    /// Clears all recorded entries.
    public func clear() {
        entries = []
    }
}

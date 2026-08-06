/// Contract for structured logging. Implement `log(_:)` to receive all entries.
public protocol LoggerProtocol: Sendable {
    func log(_ entry: LogEntry)
}

public extension LoggerProtocol {
    /// Logs a message at the `.debug` level.
    func debug(_ message: String, metadata: [String: String] = [:]) {
        log(LogEntry(level: .debug, message: message, timestamp: .now(), metadata: metadata))
    }

    /// Logs a message at the `.info` level.
    func info(_ message: String, metadata: [String: String] = [:]) {
        log(LogEntry(level: .info, message: message, timestamp: .now(), metadata: metadata))
    }

    /// Logs a message at the `.warning` level.
    func warning(_ message: String, metadata: [String: String] = [:]) {
        log(LogEntry(level: .warning, message: message, timestamp: .now(), metadata: metadata))
    }

    /// Logs a message at the `.error` level with an optional underlying error.
    func error(_ message: String, error: (any Error)? = nil, metadata: [String: String] = [:]) {
        log(LogEntry(level: .error, message: message, timestamp: .now(), metadata: metadata, error: error))
    }

    /// Logs a message at the `.critical` level with an optional underlying error.
    func critical(_ message: String, error: (any Error)? = nil, metadata: [String: String] = [:]) {
        log(LogEntry(level: .critical, message: message, timestamp: .now(), metadata: metadata, error: error))
    }
}

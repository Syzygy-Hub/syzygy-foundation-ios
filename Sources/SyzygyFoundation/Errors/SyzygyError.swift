import Foundation

/// Base error protocol for all Syzygy-domain errors.
public protocol SyzygyError: LocalizedError, Sendable {
    var code: SyzygyErrorCode { get }
    var message: String { get }
    var severity: SyzygyErrorSeverity { get }
    var underlyingError: (any Error)? { get }
}

public extension SyzygyError {
    /// Returns `message` as the localized description surfaced by `LocalizedError`.
    var errorDescription: String? { message }
}

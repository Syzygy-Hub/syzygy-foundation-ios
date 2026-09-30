import Foundation

/// A typed error model for the SyzygyFoundation layer.
///
/// Use `SyzygyFoundationError` as the concrete error type when throwing from
/// Foundation-level code. Callers can switch exhaustively over the cases or
/// inspect the `underlying` error for lower-level details.
public enum SyzygyFoundationError: Error, Sendable {
    /// A network-level failure (e.g. no connection, TLS error, timeout from the
    /// transport layer). Attach the originating error via `underlying` when available.
    case network(underlying: (any Error)?)

    /// An authentication failure (e.g. invalid token, biometric rejection).
    case authentication(underlying: (any Error)?)

    /// The requested resource could not be found (HTTP 404 equivalent).
    case notFound

    /// The operation exceeded its deadline.
    case timeout

    /// The operation was cancelled before it could complete.
    case cancelled

    /// An error that does not fit any of the above categories.
    case unknown(underlying: (any Error)?)
}

// MARK: - LocalizedError

extension SyzygyFoundationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .network(let error):
            if let error { return "Network error: \(error.localizedDescription)" }
            return "A network error occurred."
        case .authentication(let error):
            if let error { return "Authentication error: \(error.localizedDescription)" }
            return "An authentication error occurred."
        case .notFound:
            return "The requested resource was not found."
        case .timeout:
            return "The operation timed out."
        case .cancelled:
            return "The operation was cancelled."
        case .unknown(let error):
            if let error { return "An unknown error occurred: \(error.localizedDescription)" }
            return "An unknown error occurred."
        }
    }
}

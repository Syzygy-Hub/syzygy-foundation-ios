import Combine

/// Combine-based connectivity state contract.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public protocol ConnectivityProvider: AnyObject, Sendable {
    /// A publisher that emits the connectivity state on every change.
    var statePublisher: AnyPublisher<ConnectivityState, Never> { get }

    /// The current connectivity state (synchronous read).
    var state: ConnectivityState { get }

    /// Convenience accessor — equivalent to `state.isConnected`.
    var isConnected: Bool { get }
}

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

    /// Releases any underlying resources (e.g. `NWPathMonitor`) held by the provider.
    ///
    /// Call when the provider is no longer needed. After calling `dispose()`, the
    /// behaviour of other methods and properties is undefined.
    func dispose()
}

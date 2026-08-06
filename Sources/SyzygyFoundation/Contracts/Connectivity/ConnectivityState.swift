/// The current network connectivity state.
public enum ConnectivityState: Equatable, Sendable {
    case connected
    case disconnected
    case unknown

    /// True when the state is `.connected`.
    public var isConnected: Bool {
        self == .connected
    }
}

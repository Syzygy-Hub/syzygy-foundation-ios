import Combine
import SyzygyFoundation

/// A test connectivity provider with a settable state.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public final class MockConnectivityProvider: ConnectivityProvider, @unchecked Sendable {
    private let subject: CurrentValueSubject<ConnectivityState, Never>

    public init(initialState: ConnectivityState = .unknown) {
        self.subject = CurrentValueSubject(initialState)
    }

    public var state: ConnectivityState {
        get { subject.value }
        set { subject.send(newValue) }
    }

    public var statePublisher: AnyPublisher<ConnectivityState, Never> {
        subject.eraseToAnyPublisher()
    }

    public var isConnected: Bool { state.isConnected }
}

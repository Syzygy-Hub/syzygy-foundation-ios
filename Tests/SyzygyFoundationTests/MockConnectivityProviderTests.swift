import Testing
import Combine
import SyzygyFoundation
import SyzygyFoundationTesting

@Suite struct MockConnectivityProviderTests {
    @Test func defaultInitialStateIsUnknown() {
        let provider = MockConnectivityProvider()
        #expect(provider.state == .unknown)
        #expect(provider.isConnected == false)
    }

    @Test func customInitialStateConnected() {
        let provider = MockConnectivityProvider(initialState: .connected)
        #expect(provider.state == .connected)
        #expect(provider.isConnected == true)
    }

    @Test func customInitialStateDisconnected() {
        let provider = MockConnectivityProvider(initialState: .disconnected)
        #expect(provider.isConnected == false)
    }

    @Test func setStateToConnectedUpdatesIsConnected() {
        let provider = MockConnectivityProvider()
        provider.state = .connected
        #expect(provider.isConnected == true)
    }

    @Test func setStateToDisconnectedUpdatesIsConnected() {
        let provider = MockConnectivityProvider(initialState: .connected)
        provider.state = .disconnected
        #expect(provider.isConnected == false)
    }

    @Test func setStateToUnknownSetsIsConnectedFalse() {
        let provider = MockConnectivityProvider(initialState: .connected)
        provider.state = .unknown
        #expect(provider.isConnected == false)
    }

    @Test func statePublisherEmitsOnStateChange() async {
        let provider = MockConnectivityProvider(initialState: .connected)
        var observed: [ConnectivityState] = []
        var cancellables = Set<AnyCancellable>()
        provider.statePublisher
            .dropFirst() // drop current value
            .sink { observed.append($0) }
            .store(in: &cancellables)
        provider.state = .disconnected
        provider.state = .connected
        // Give Combine a moment to deliver
        try? await Task.sleep(nanoseconds: 1_000_000)
        #expect(observed == [.disconnected, .connected])
    }
}

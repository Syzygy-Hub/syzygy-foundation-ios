import Testing
import Combine
import SyzygyFoundation
import SyzygyFoundationTesting

@Suite struct MockAuthProviderTests {
    private let token = AuthToken(accessToken: "access-token")

    @Test func initialStateIsUnauthenticated() {
        let provider = MockAuthProvider()
        #expect(provider.state == .unauthenticated)
        #expect(provider.state.isAuthenticated == false)
    }

    @Test func authenticateTransitionsToAuthenticated() {
        let provider = MockAuthProvider()
        provider.authenticate(token: token)
        #expect(provider.state.isAuthenticated == true)
    }

    @Test func tokenIsAccessibleAfterAuthenticate() {
        let provider = MockAuthProvider()
        provider.authenticate(token: token)
        #expect(provider.state.token == token)
    }

    @Test func signOutTransitionsToUnauthenticated() {
        let provider = MockAuthProvider()
        provider.authenticate(token: token)
        provider.signOut()
        #expect(provider.state.isAuthenticated == false)
    }

    @Test func signOutIncrementsSignOutCallCount() {
        let provider = MockAuthProvider()
        provider.signOut()
        provider.signOut()
        #expect(provider.signOutCallCount == 2)
    }

    @Test func refreshIncrementsRefreshCallCount() async throws {
        let provider = MockAuthProvider()
        _ = try await provider.refresh()
        _ = try await provider.refresh()
        #expect(provider.refreshCallCount == 2)
    }

    @Test func statePublisherEmitsOnStateChanges() async {
        let provider = MockAuthProvider()
        var observed: [AuthState] = []
        var cancellables = Set<AnyCancellable>()
        provider.statePublisher
            .dropFirst()
            .sink { observed.append($0) }
            .store(in: &cancellables)
        provider.authenticate(token: token)
        provider.signOut()
        try? await Task.sleep(nanoseconds: 1_000_000)
        #expect(observed.count == 2)
        #expect(observed[0].isAuthenticated == true)
        #expect(observed[1].isAuthenticated == false)
    }
}

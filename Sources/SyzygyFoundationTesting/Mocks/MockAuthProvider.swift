import Combine
import SyzygyFoundation

/// A test auth provider with settable state and call counters.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public final class MockAuthProvider: AuthProvider, @unchecked Sendable {
    private let subject: CurrentValueSubject<AuthState, Never>

    public var refreshCallCount: Int = 0
    public var signOutCallCount: Int = 0
    public var refreshResult: Result<AuthToken, any Error> = .success(AuthToken.fixture())

    public init(initialState: AuthState = .unauthenticated) {
        self.subject = CurrentValueSubject(initialState)
    }

    public var state: AuthState {
        get { subject.value }
        set { subject.send(newValue) }
    }

    public var statePublisher: AnyPublisher<AuthState, Never> {
        subject.eraseToAnyPublisher()
    }

    public func authenticate(token: AuthToken) {
        state = .authenticated(token: token)
    }

    public func refresh() async throws -> AuthToken {
        refreshCallCount += 1
        return try refreshResult.get()
    }

    public func signOut() {
        signOutCallCount += 1
        state = .unauthenticated
    }
}

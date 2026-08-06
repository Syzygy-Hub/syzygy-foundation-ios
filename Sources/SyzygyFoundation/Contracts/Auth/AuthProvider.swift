import Combine

/// Combine-based auth state contract.
///
/// Requires iOS 16+ / macOS 10.15+ (Combine AnyPublisher).
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public protocol AuthProvider: AnyObject, Sendable {
    /// A publisher that emits the current auth state on every change.
    var statePublisher: AnyPublisher<AuthState, Never> { get }

    /// The current auth state (synchronous read).
    var state: AuthState { get }

    /// Stores the given token and transitions to `.authenticated`.
    func authenticate(token: AuthToken)

    /// Refreshes the access token. Throws on failure.
    func refresh() async throws -> AuthToken

    /// Signs out and transitions to `.unauthenticated`.
    func signOut()
}

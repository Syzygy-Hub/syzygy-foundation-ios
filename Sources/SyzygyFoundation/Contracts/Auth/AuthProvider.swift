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

    /// Returns whether biometric authentication is available and enrolled on
    /// this device.
    ///
    /// - Returns: `true` if Face ID / Touch ID is available and the user has
    ///   enrolled at least one biometric; `false` otherwise (including when
    ///   the user has denied the app biometric permission).
    func canUseBiometric() -> Bool

    /// Presents the system biometric prompt with the given reason string and
    /// returns the outcome.
    ///
    /// - Parameter reason: A localised string shown to the user in the system
    ///   prompt that explains why the app is requesting biometric auth.
    /// - Returns: `true` if authentication succeeded; `false` if it failed,
    ///   was cancelled, or is unavailable.
    func authenticateWithBiometric(reason: String) async -> Bool

    /// Attempts a background token refresh without requiring user interaction.
    ///
    /// - Returns: `true` if the token was successfully refreshed; `false` otherwise.
    func refreshToken() async -> Bool
}

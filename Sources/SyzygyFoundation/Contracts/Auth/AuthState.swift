/// The current authentication state of the user session.
public enum AuthState: Equatable, Sendable {
    case unauthenticated
    case authenticated(token: AuthToken)
    case expired(token: AuthToken)
    case refreshing

    /// True when the state is `.authenticated`.
    public var isAuthenticated: Bool {
        if case .authenticated = self { return true }
        return false
    }

    /// Returns the token for `.authenticated` or `.expired` states, nil otherwise.
    public var token: AuthToken? {
        switch self {
        case .authenticated(let token): return token
        case .expired(let token): return token
        default: return nil
        }
    }
}

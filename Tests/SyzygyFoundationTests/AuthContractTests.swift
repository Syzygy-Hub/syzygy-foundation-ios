import Testing
import SyzygyFoundation

@Suite struct AuthTokenTests {
    @Test func isExpiredFalseWhenNoExpiresAt() {
        let token = AuthToken(accessToken: "tok")
        #expect(token.isExpired == false)
    }

    @Test func isExpiredTrueWhenExpiresAtInPast() {
        let past = SyzygyTimestamp(millisecondsSinceEpoch: 1) // 1ms after epoch — always past
        let token = AuthToken(accessToken: "tok", expiresAt: past)
        #expect(token.isExpired == true)
    }

    @Test func isExpiredFalseWhenExpiresAtInFuture() {
        let futureMs = SyzygyTimestamp.now().millisecondsSinceEpoch + 3_600_000
        let future = SyzygyTimestamp(millisecondsSinceEpoch: futureMs)
        let token = AuthToken(accessToken: "tok", expiresAt: future)
        #expect(token.isExpired == false)
    }
}

@Suite struct AuthStateTests {
    private let token = AuthToken(accessToken: "tok")

    @Test func isAuthenticatedTrueOnlyForAuthenticated() {
        #expect(AuthState.authenticated(token: token).isAuthenticated == true)
        #expect(AuthState.unauthenticated.isAuthenticated == false)
        #expect(AuthState.expired(token: token).isAuthenticated == false)
        #expect(AuthState.refreshing.isAuthenticated == false)
    }

    @Test func tokenReturnsTokenForAuthenticatedState() {
        #expect(AuthState.authenticated(token: token).token == token)
    }

    @Test func tokenReturnsTokenForExpiredState() {
        #expect(AuthState.expired(token: token).token == token)
    }

    @Test func tokenReturnsNilForUnauthenticated() {
        #expect(AuthState.unauthenticated.token == nil)
    }

    @Test func tokenReturnsNilForRefreshing() {
        #expect(AuthState.refreshing.token == nil)
    }
}

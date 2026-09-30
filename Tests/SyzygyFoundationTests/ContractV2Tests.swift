import Testing
import SyzygyFoundation
import SyzygyFoundationTesting

// MARK: - dispose() tests

struct DisposeTests {
    @Test func networkClientDisposeDoesNotThrow() {
        let client = MockNetworkClient()
        client.dispose()
        // If we reach here dispose() completed without error.
        #expect(Bool(true))
    }

    @Test func connectivityProviderDisposeDoesNotThrow() {
        let provider = MockConnectivityProvider()
        provider.dispose()
        #expect(Bool(true))
    }
}

// MARK: - AuthProvider v2.0.0 method tests

struct AuthProviderV2Tests {
    @Test func canUseBiometricReturnsBool() {
        let auth = MockAuthProvider()
        let result = auth.canUseBiometric()
        #expect(result == false) // default is false

        auth.canUseBiometricResult = true
        #expect(auth.canUseBiometric() == true)
    }

    @Test func authenticateWithBiometricReturnsBool() async {
        let auth = MockAuthProvider()
        let defaultResult = await auth.authenticateWithBiometric(reason: "Test")
        #expect(defaultResult == false)

        auth.authenticateWithBiometricResult = true
        let trueResult = await auth.authenticateWithBiometric(reason: "Test")
        #expect(trueResult == true)
    }

    @Test func refreshTokenReturnsBool() async {
        let auth = MockAuthProvider()
        let defaultResult = await auth.refreshToken()
        #expect(defaultResult == false)

        auth.refreshTokenResult = true
        let trueResult = await auth.refreshToken()
        #expect(trueResult == true)
    }
}

// MARK: - SyzygyFoundationError construction tests

struct SyzygyFoundationErrorTests {
    @Test func networkCaseCanBeConstructed() {
        let error: SyzygyFoundationError = .network(underlying: nil)
        if case .network = error { } else {
            Issue.record("Expected .network case")
        }
    }

    @Test func authenticationCaseCanBeConstructed() {
        let error: SyzygyFoundationError = .authentication(underlying: nil)
        if case .authentication = error { } else {
            Issue.record("Expected .authentication case")
        }
    }

    @Test func notFoundCaseCanBeConstructed() {
        let error: SyzygyFoundationError = .notFound
        if case .notFound = error { } else {
            Issue.record("Expected .notFound case")
        }
    }

    @Test func timeoutCaseCanBeConstructed() {
        let error: SyzygyFoundationError = .timeout
        if case .timeout = error { } else {
            Issue.record("Expected .timeout case")
        }
    }

    @Test func cancelledCaseCanBeConstructed() {
        let error: SyzygyFoundationError = .cancelled
        if case .cancelled = error { } else {
            Issue.record("Expected .cancelled case")
        }
    }

    @Test func unknownCaseCanBeConstructed() {
        let error: SyzygyFoundationError = .unknown(underlying: nil)
        if case .unknown = error { } else {
            Issue.record("Expected .unknown case")
        }
    }

    @Test func errorDescriptionIsNonNil() {
        let cases: [SyzygyFoundationError] = [
            .network(underlying: nil),
            .authentication(underlying: nil),
            .notFound,
            .timeout,
            .cancelled,
            .unknown(underlying: nil)
        ]
        for error in cases {
            #expect(error.errorDescription != nil)
        }
    }
}

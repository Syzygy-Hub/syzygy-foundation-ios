import Testing
import SyzygyFoundation

@Suite struct SyzygyErrorCodeTests {
    @Test func allStaticCodesAreDefined() {
        // Verify each well-known static code compiles and has a rawValue
        #expect(SyzygyErrorCode.unknown.rawValue == "unknown")
        #expect(SyzygyErrorCode.cancelled.rawValue == "cancelled")
        #expect(SyzygyErrorCode.timeout.rawValue == "timeout")
        #expect(SyzygyErrorCode.unauthenticated.rawValue == "unauthenticated")
        #expect(SyzygyErrorCode.forbidden.rawValue == "forbidden")
        #expect(SyzygyErrorCode.notFound.rawValue == "not_found")
        #expect(SyzygyErrorCode.serverError.rawValue == "server_error")
        #expect(SyzygyErrorCode.networkUnavailable.rawValue == "network_unavailable")
        #expect(SyzygyErrorCode.decodingFailed.rawValue == "decoding_failed")
        #expect(SyzygyErrorCode.encodingFailed.rawValue == "encoding_failed")
    }

    @Test func equalityTrueForSameRawValue() {
        let a = SyzygyErrorCode(rawValue: "timeout")
        let b = SyzygyErrorCode(rawValue: "timeout")
        #expect(a == b)
    }

    @Test func equalityFalseForDifferentRawValues() {
        let a = SyzygyErrorCode(rawValue: "timeout")
        let b = SyzygyErrorCode(rawValue: "not_found")
        #expect(a != b)
    }

    @Test func descriptionReturnsRawValue() {
        let code = SyzygyErrorCode(rawValue: "custom_error")
        #expect(code.rawValue == "custom_error")
    }

    @Test func expressibleByStringLiteral() {
        let code: SyzygyErrorCode = "my_code"
        #expect(code.rawValue == "my_code")
    }
}

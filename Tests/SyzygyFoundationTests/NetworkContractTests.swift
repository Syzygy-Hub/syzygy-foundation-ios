import Testing
import Foundation
import SyzygyFoundation

@Suite struct NetworkRequestTests {
    @Test func defaultTimeoutIs30() {
        let req = NetworkRequest(url: "https://example.com", method: .get)
        #expect(req.timeoutSeconds == 30.0)
    }

    @Test func customTimeoutIsRespected() {
        let req = NetworkRequest(url: "https://example.com", method: .post, timeoutSeconds: 60.0)
        #expect(req.timeoutSeconds == 60.0)
    }

    @Test func headersDefaultToEmpty() {
        let req = NetworkRequest(url: "https://example.com", method: .get)
        #expect(req.headers.isEmpty)
    }
}

@Suite struct NetworkResponseTests {
    private func response(_ code: Int) -> NetworkResponse {
        NetworkResponse(statusCode: code, data: Data(), headers: [:])
    }

    @Test func isSuccessTrueFor200() { #expect(response(200).isSuccess == true) }
    @Test func isSuccessTrueFor299() { #expect(response(299).isSuccess == true) }
    @Test func isSuccessFalseFor300() { #expect(response(300).isSuccess == false) }
    @Test func isSuccessFalseFor400() { #expect(response(400).isSuccess == false) }
    @Test func isSuccessFalseFor500() { #expect(response(500).isSuccess == false) }

    @Test func isClientErrorTrueFor400() { #expect(response(400).isClientError == true) }
    @Test func isClientErrorTrueFor499() { #expect(response(499).isClientError == true) }
    @Test func isClientErrorFalseFor500() { #expect(response(500).isClientError == false) }
    @Test func isClientErrorFalseFor200() { #expect(response(200).isClientError == false) }

    @Test func isServerErrorTrueFor500() { #expect(response(500).isServerError == true) }
    @Test func isServerErrorTrueFor599() { #expect(response(599).isServerError == true) }
    @Test func isServerErrorFalseFor400() { #expect(response(400).isServerError == false) }
}

@Suite struct NetworkMethodTests {
    @Test func rawValues() {
        #expect(NetworkMethod.get.rawValue == "GET")
        #expect(NetworkMethod.post.rawValue == "POST")
        #expect(NetworkMethod.put.rawValue == "PUT")
        #expect(NetworkMethod.patch.rawValue == "PATCH")
        #expect(NetworkMethod.delete.rawValue == "DELETE")
        #expect(NetworkMethod.head.rawValue == "HEAD")
    }
}

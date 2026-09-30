import Testing
import Foundation
import SyzygyFoundation
import SyzygyFoundationTesting

@Suite struct MockNetworkClientTests {
    private func makeRequest(url: String = "https://example.com") -> NetworkRequest {
        NetworkRequest(url: url, method: .get)
    }

    private func makeResponse(statusCode: Int = 200) -> NetworkResponse {
        NetworkResponse(statusCode: statusCode, data: Data(), headers: [:])
    }

    @Test func executeReturnsQueuedResponse() async throws {
        let client = MockNetworkClient()
        client.responses.append(makeResponse(statusCode: 200))
        let result = try await client.execute(makeRequest())
        #expect(result.statusCode == 200)
    }

    @Test func executeConsumesFIFOOrder() async throws {
        let client = MockNetworkClient()
        client.responses.append(makeResponse(statusCode: 200))
        client.responses.append(makeResponse(statusCode: 404))
        let first = try await client.execute(makeRequest())
        let second = try await client.execute(makeRequest())
        #expect(first.statusCode == 200)
        #expect(second.statusCode == 404)
    }

    @Test func executeRecordsRequest() async throws {
        let client = MockNetworkClient()
        client.responses.append(makeResponse())
        let req = makeRequest(url: "https://example.com")
        _ = try await client.execute(req)
        #expect(client.requests.count == 1)
        #expect(client.requests[0].url == "https://example.com")
    }

    @Test func executeThrowsConfiguredError() async throws {
        let client = MockNetworkClient()
        struct Sentinel: Error {}
        client.error = Sentinel()
        do {
            _ = try await client.execute(makeRequest())
            Issue.record("Expected an error to be thrown")
        } catch {
            // expected
        }
    }

    @Test func executeThrowsWhenQueueIsEmpty() async throws {
        let client = MockNetworkClient()
        do {
            _ = try await client.execute(makeRequest())
            Issue.record("Expected MockNetworkClientError.noResponseQueued")
        } catch MockNetworkClientError.noResponseQueued {
            // expected
        }
    }
}

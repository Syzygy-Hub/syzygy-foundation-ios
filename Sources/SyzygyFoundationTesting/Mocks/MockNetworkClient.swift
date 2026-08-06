import Foundation
import SyzygyFoundation

/// A test network client that records requests and dequeues preset responses.
public final class MockNetworkClient: NetworkClientProtocol, @unchecked Sendable {
    public var responses: [NetworkResponse] = []
    public var requests: [NetworkRequest] = []
    public var error: (any Error)?

    public init() {}

    public func execute(_ request: NetworkRequest) async throws -> NetworkResponse {
        requests.append(request)
        if let error = error { throw error }
        guard !responses.isEmpty else {
            throw MockNetworkClientError.noResponseQueued
        }
        return responses.removeFirst()
    }
}

public enum MockNetworkClientError: Error {
    case noResponseQueued
}

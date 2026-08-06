/// Contract for executing network requests asynchronously.
public protocol NetworkClientProtocol: Sendable {
    func execute(_ request: NetworkRequest) async throws -> NetworkResponse
}

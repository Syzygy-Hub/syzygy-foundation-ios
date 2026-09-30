/// Contract for executing network requests asynchronously.
public protocol NetworkClientProtocol: Sendable {
    func execute(_ request: NetworkRequest) async throws -> NetworkResponse

    /// Cancels any in-flight requests and releases held resources.
    ///
    /// Call this when the client is no longer needed — for example when the
    /// owning object is deallocated or the session is invalidated.  After
    /// `dispose()` returns, further calls to `execute(_:)` may throw or
    /// produce undefined behaviour depending on the implementation.
    func dispose()
}

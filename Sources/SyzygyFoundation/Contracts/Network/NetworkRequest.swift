import Foundation

/// A typed HTTP request value type.
public struct NetworkRequest: Equatable, Sendable {
    public var url: String
    public var method: NetworkMethod
    public var headers: [String: String]
    public var body: Data?
    public var timeoutSeconds: Double

    public init(
        url: String,
        method: NetworkMethod,
        headers: [String: String] = [:],
        body: Data? = nil,
        timeoutSeconds: Double = 30.0
    ) {
        self.url = url
        self.method = method
        self.headers = headers
        self.body = body
        self.timeoutSeconds = timeoutSeconds
    }
}

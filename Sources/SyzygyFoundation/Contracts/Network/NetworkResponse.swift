import Foundation

/// A typed HTTP response with status-range helpers.
public struct NetworkResponse: Equatable, Sendable {
    public let statusCode: Int
    public let data: Data
    public let headers: [String: String]

    public init(statusCode: Int, data: Data, headers: [String: String]) {
        self.statusCode = statusCode
        self.data = data
        self.headers = headers
    }

    /// True for HTTP 2xx status codes.
    public var isSuccess: Bool { (200...299).contains(statusCode) }

    /// True for HTTP 4xx status codes.
    public var isClientError: Bool { (400...499).contains(statusCode) }

    /// True for HTTP 5xx status codes.
    public var isServerError: Bool { (500...599).contains(statusCode) }
}

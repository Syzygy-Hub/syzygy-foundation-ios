/// Page number, size, and optional cursor for paginated requests.
public struct PaginationRequest: Equatable, Codable, Sendable {
    public var pageNumber: Int
    public var pageSize: Int
    public var cursor: String?

    public init(pageNumber: Int = 1, pageSize: Int = 20, cursor: String? = nil) {
        self.pageNumber = pageNumber
        self.pageSize = pageSize
        self.cursor = cursor
    }
}

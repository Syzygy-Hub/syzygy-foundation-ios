/// A generic typed page of results with pagination metadata.
public struct Page<T> {
    /// The elements on this page.
    public let items: [T]
    /// The total number of elements across all pages.
    public let totalCount: Int
    /// The 1-based index of this page.
    public let pageNumber: Int
    /// The maximum number of elements per page.
    public let pageSize: Int

    /// Creates a new page with the given items and pagination metadata.
    public init(items: [T], totalCount: Int, pageNumber: Int, pageSize: Int) {
        self.items = items
        self.totalCount = totalCount
        self.pageNumber = pageNumber
        self.pageSize = pageSize
    }

    /// True when there are more pages after this one.
    public var hasNextPage: Bool { pageNumber * pageSize < totalCount }

    /// True when this is not the first page.
    public var hasPreviousPage: Bool { pageNumber > 1 }

    /// True when the items array is empty.
    public var isEmpty: Bool { items.isEmpty }

    /// Total number of pages (ceiling division).
    public var totalPages: Int {
        guard pageSize > 0 else { return 0 }
        return (totalCount + pageSize - 1) / pageSize
    }
}

extension Page: Equatable where T: Equatable {}
extension Page: Codable where T: Codable {}
extension Page: Sendable where T: Sendable {}

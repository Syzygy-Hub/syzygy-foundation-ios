import Testing
import SyzygyFoundation

struct PageTests {
    @Test func isEmpty() {
        let page = Page<Int>(items: [], totalCount: 0, pageNumber: 1, pageSize: 20)
        #expect(page.isEmpty)
    }

    @Test func isNotEmpty() {
        let page = Page<Int>(items: [1, 2, 3], totalCount: 3, pageNumber: 1, pageSize: 20)
        #expect(!page.isEmpty)
    }

    @Test func totalPages() {
        let page = Page<Int>(items: [], totalCount: 55, pageNumber: 1, pageSize: 20)
        #expect(page.totalPages == 3)
    }

    @Test func hasNextPage() {
        let page = Page<Int>(items: [], totalCount: 55, pageNumber: 2, pageSize: 20)
        // page 2 * 20 = 40 < 55
        #expect(page.hasNextPage)
    }

    @Test func noNextPageOnLastPage() {
        let page = Page<Int>(items: [], totalCount: 40, pageNumber: 2, pageSize: 20)
        // 2 * 20 = 40 == 40
        #expect(!page.hasNextPage)
    }

    @Test func hasPreviousPage() {
        let page = Page<Int>(items: [], totalCount: 100, pageNumber: 2, pageSize: 20)
        #expect(page.hasPreviousPage)
    }

    @Test func noPreviewPageOnFirstPage() {
        let page = Page<Int>(items: [], totalCount: 100, pageNumber: 1, pageSize: 20)
        #expect(!page.hasPreviousPage)
    }
}

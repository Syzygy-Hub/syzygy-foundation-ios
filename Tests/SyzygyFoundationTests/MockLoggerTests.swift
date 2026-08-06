import Testing
import SyzygyFoundation
import SyzygyFoundationTesting

struct MockLoggerTests {
    @Test func entriesAreRecorded() {
        let logger = MockLogger()
        logger.info("hello")
        logger.debug("world")
        #expect(logger.entries.count == 2)
    }

    @Test func filterByLevel() {
        let logger = MockLogger()
        logger.info("info one")
        logger.info("info two")
        logger.warning("a warning")
        #expect(logger.entries(for: .info).count == 2)
        #expect(logger.entries(for: .warning).count == 1)
        #expect(logger.entries(for: .error).isEmpty)
    }

    @Test func clear() {
        let logger = MockLogger()
        logger.info("message")
        logger.clear()
        #expect(logger.entries.isEmpty)
    }
}

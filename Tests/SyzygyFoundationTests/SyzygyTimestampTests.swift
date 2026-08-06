import Testing
import Foundation
import SyzygyFoundation

struct SyzygyTimestampTests {
    @Test func nowReturnsReasonableValue() {
        let timestamp = SyzygyTimestamp.now()
        // Must be after 2020-01-01 (1577836800000 ms)
        #expect(timestamp.millisecondsSinceEpoch > 1_577_836_800_000)
    }

    @Test func comparable() {
        let earlier = SyzygyTimestamp(millisecondsSinceEpoch: 1000)
        let later = SyzygyTimestamp(millisecondsSinceEpoch: 2000)
        #expect(earlier < later)
        #expect(!(later < earlier))
    }

    @Test func dateConversion() {
        let timestamp = SyzygyTimestamp(millisecondsSinceEpoch: 1_000_000)
        #expect(timestamp.date.timeIntervalSince1970 == 1000.0)
    }
}

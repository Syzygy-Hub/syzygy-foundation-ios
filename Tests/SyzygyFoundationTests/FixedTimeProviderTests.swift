import Testing
import SyzygyFoundation
import SyzygyFoundationTesting

struct FixedTimeProviderTests {
    @Test func nowReturnsFixedTime() {
        let fixed = SyzygyTimestamp(millisecondsSinceEpoch: 5000)
        let provider = FixedTimeProvider(fixedTime: fixed)
        #expect(provider.now() == fixed)
    }

    @Test func sinceComputesDuration() {
        let provider = FixedTimeProvider(fixedTime: SyzygyTimestamp(millisecondsSinceEpoch: 10_000))
        let earlier = SyzygyTimestamp(millisecondsSinceEpoch: 3_000)
        let duration = provider.since(earlier)
        #expect(duration.milliseconds == 7_000)
    }
}

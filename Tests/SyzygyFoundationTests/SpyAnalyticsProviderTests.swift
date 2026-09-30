import Testing
import SyzygyFoundation
import SyzygyFoundationTesting

@Suite struct SpyAnalyticsProviderTests {
    @Test func trackRecordsEvents() {
        let spy = SpyAnalyticsProvider()
        spy.track(AnalyticsEvent(name: "button_tapped"))
        #expect(spy.trackedEvents.count == 1)
        #expect(spy.trackedEvents[0].name == "button_tapped")
    }

    @Test func eventsNamedFiltersByName() {
        let spy = SpyAnalyticsProvider()
        spy.track(AnalyticsEvent(name: "page_view"))
        spy.track(AnalyticsEvent(name: "button_tapped"))
        spy.track(AnalyticsEvent(name: "page_view"))
        #expect(spy.events(named: "page_view").count == 2)
        #expect(spy.events(named: "button_tapped").count == 1)
    }

    @Test func identifyRecordsUserIdAndTraits() {
        let spy = SpyAnalyticsProvider()
        spy.identify(userId: "user-123", traits: ["plan": "pro"])
        #expect(spy.identifiedUsers.count == 1)
        #expect(spy.identifiedUsers[0].userId == "user-123")
        #expect(spy.identifiedUsers[0].traits == ["plan": "pro"])
    }

    @Test func resetIncrementsResetCallCount() {
        let spy = SpyAnalyticsProvider()
        spy.reset()
        spy.reset()
        #expect(spy.resetCallCount == 2)
    }

    @Test func trackedEventsAccumulateInOrder() {
        let spy = SpyAnalyticsProvider()
        spy.track(AnalyticsEvent(name: "first"))
        spy.track(AnalyticsEvent(name: "second"))
        #expect(spy.trackedEvents[0].name == "first")
        #expect(spy.trackedEvents[1].name == "second")
    }
}

import Testing
import SyzygyFoundation

struct SyzygyIDTests {
    @Test func generateProducesUniqueIDs() {
        struct Phantom {}
        let idOne = SyzygyID<Phantom>.generate()
        let idTwo = SyzygyID<Phantom>.generate()
        #expect(idOne != idTwo)
    }

    @Test func rawValueRoundTrip() {
        struct Phantom {}
        let identifier = SyzygyID<Phantom>(rawValue: "abc-123")
        #expect(identifier.rawValue == "abc-123")
        #expect(identifier.description == "abc-123")
    }

    @Test func comparable() {
        struct Phantom {}
        let low = SyzygyID<Phantom>(rawValue: "aaa")
        let high = SyzygyID<Phantom>(rawValue: "zzz")
        #expect(low < high)
        #expect(!(high < low))
    }
}

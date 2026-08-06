import Testing
import SyzygyFoundation

struct SyzygyVersionTests {
    @Test func descriptionWithoutPrerelease() {
        let version = SyzygyVersion(1, 0, 0)
        #expect(version.description == "1.0.0")
    }

    @Test func descriptionWithPrerelease() {
        let version = SyzygyVersion(1, 2, 3, prerelease: "beta")
        #expect(version.description == "1.2.3-beta")
    }

    @Test func comparable() {
        let v100 = SyzygyVersion(1, 0, 0)
        let v110 = SyzygyVersion(1, 1, 0)
        let v200 = SyzygyVersion(2, 0, 0)
        #expect(v100 < v110)
        #expect(v110 < v200)
        #expect(!(v200 < v100))
    }
}

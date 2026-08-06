import Testing
import SyzygyFoundation

struct ValidationResultTests {
    @Test func validIsValid() {
        let result = ValidationResult.valid
        #expect(result.isValid)
        #expect(result.messages.isEmpty)
    }

    @Test func invalidIsNotValid() {
        let result = ValidationResult.invalid(messages: ["Too short", "Missing special char"])
        #expect(!result.isValid)
        #expect(result.messages == ["Too short", "Missing special char"])
    }
}

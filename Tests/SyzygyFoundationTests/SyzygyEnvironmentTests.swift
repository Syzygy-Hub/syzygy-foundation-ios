import Testing
import SyzygyFoundation

@Suite struct SyzygyEnvironmentTests {
    @Test func isDebugTrueOnlyForDebug() {
        #expect(SyzygyEnvironment.debug.isDebug == true)
        #expect(SyzygyEnvironment.staging.isDebug == false)
        #expect(SyzygyEnvironment.production.isDebug == false)
    }

    @Test func isProductionTrueOnlyForProduction() {
        #expect(SyzygyEnvironment.production.isProduction == true)
        #expect(SyzygyEnvironment.debug.isProduction == false)
        #expect(SyzygyEnvironment.staging.isProduction == false)
    }

    @Test func descriptionReturnsRawValue() {
        #expect(SyzygyEnvironment.debug.description == "debug")
        #expect(SyzygyEnvironment.staging.description == "staging")
        #expect(SyzygyEnvironment.production.description == "production")
    }
}

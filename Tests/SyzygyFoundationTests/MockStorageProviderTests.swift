import Testing
import SyzygyFoundation
import SyzygyFoundationTesting

@Suite struct MockStorageProviderTests {
    private let key = StorageKey<String>(identifier: "test-key")

    @Test func setThenGetReturnsStoredValue() {
        let store = MockStorageProvider()
        store.set("hello", for: key)
        #expect(store.get(key) == "hello")
    }

    @Test func getReturnsNilForMissingKey() {
        let store = MockStorageProvider()
        #expect(store.get(key) == nil)
    }

    @Test func removeDeletesTheValue() {
        let store = MockStorageProvider()
        store.set("hello", for: key)
        store.remove(key)
        #expect(store.get(key) == nil)
    }

    @Test func clearEmptiesAllStorage() {
        let store = MockStorageProvider()
        store.set("a", for: StorageKey<String>(identifier: "key1"))
        store.set("b", for: StorageKey<String>(identifier: "key2"))
        store.clear()
        #expect(store.storage.isEmpty)
    }

    @Test func storesMultipleKeysIndependently() {
        let store = MockStorageProvider()
        let keyA = StorageKey<String>(identifier: "keyA")
        let keyB = StorageKey<String>(identifier: "keyB")
        store.set("valueA", for: keyA)
        store.set("valueB", for: keyB)
        #expect(store.get(keyA) == "valueA")
        #expect(store.get(keyB) == "valueB")
    }
}

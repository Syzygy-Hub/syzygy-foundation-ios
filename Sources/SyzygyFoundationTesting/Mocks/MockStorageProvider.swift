import Foundation
import SyzygyFoundation

/// An in-memory storage provider backed by a dictionary.
public final class MockStorageProvider: StorageProvider, @unchecked Sendable {
    public var storage: [String: Any] = [:]

    public init() {}

    public func get<T: Codable & Sendable>(_ key: StorageKey<T>) -> T? {
        guard let data = storage[key.identifier] as? Data else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }

    public func set<T: Codable & Sendable>(_ value: T, for key: StorageKey<T>) {
        storage[key.identifier] = try? JSONEncoder().encode(value)
    }

    public func remove<T: Sendable>(_ key: StorageKey<T>) {
        storage.removeValue(forKey: key.identifier)
    }

    public func clear() {
        storage.removeAll()
    }
}

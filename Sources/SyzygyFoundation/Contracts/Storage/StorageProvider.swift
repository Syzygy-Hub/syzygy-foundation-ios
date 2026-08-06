/// Contract for persistent or in-memory key–value storage.
public protocol StorageProvider: Sendable {
    func get<T: Codable & Sendable>(_ key: StorageKey<T>) -> T?
    func set<T: Codable & Sendable>(_ value: T, for key: StorageKey<T>)
    func remove<T: Sendable>(_ key: StorageKey<T>)
    func clear()
}

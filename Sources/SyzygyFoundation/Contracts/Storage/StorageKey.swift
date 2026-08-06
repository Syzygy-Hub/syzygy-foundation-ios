/// A generic typed storage key.
///
/// Hashable conformance is based on `identifier` only; the phantom type
/// ensures keys for different value types cannot be confused at the call site.
public struct StorageKey<T>: Equatable, Hashable, Sendable where T: Sendable {
    public let identifier: String
    public let defaultValue: T?

    public init(identifier: String, defaultValue: T? = nil) {
        self.identifier = identifier
        self.defaultValue = defaultValue
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    public static func == (lhs: StorageKey<T>, rhs: StorageKey<T>) -> Bool {
        lhs.identifier == rhs.identifier
    }
}

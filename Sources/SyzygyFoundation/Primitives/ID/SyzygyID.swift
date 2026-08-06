import Foundation

/// A generic typed identifier wrapping a UUID-based String.
public struct SyzygyID<T>: Equatable, Hashable, Comparable, Codable, CustomStringConvertible, Sendable {
    public var rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }

    public static func generate() -> SyzygyID<T> {
        SyzygyID(rawValue: UUID().uuidString)
    }

    public static func < (lhs: SyzygyID<T>, rhs: SyzygyID<T>) -> Bool {
        lhs.rawValue < rhs.rawValue
    }

    public var description: String { rawValue }
}

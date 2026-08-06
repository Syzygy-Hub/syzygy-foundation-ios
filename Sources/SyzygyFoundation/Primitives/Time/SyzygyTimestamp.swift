import Foundation

/// Cross-platform time primitive expressed as milliseconds since the Unix epoch.
public struct SyzygyTimestamp: Equatable, Comparable, Codable, Sendable {
    public let millisecondsSinceEpoch: Int64

    public init(millisecondsSinceEpoch: Int64) {
        self.millisecondsSinceEpoch = millisecondsSinceEpoch
    }

    /// Returns the current time as a SyzygyTimestamp.
    public static func now() -> SyzygyTimestamp {
        SyzygyTimestamp(millisecondsSinceEpoch: Int64(Date().timeIntervalSince1970 * 1000))
    }

    /// Seconds since the Unix epoch.
    public var secondsSinceEpoch: Double {
        Double(millisecondsSinceEpoch) / 1000.0
    }

    /// Convenience conversion to Foundation Date (iOS only).
    public var date: Date {
        Date(timeIntervalSince1970: secondsSinceEpoch)
    }

    public static func < (lhs: SyzygyTimestamp, rhs: SyzygyTimestamp) -> Bool {
        lhs.millisecondsSinceEpoch < rhs.millisecondsSinceEpoch
    }
}

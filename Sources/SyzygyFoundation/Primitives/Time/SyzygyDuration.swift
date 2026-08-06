/// Typed duration wrapper with factory methods for common time units.
public struct SyzygyDuration: Equatable, Comparable, Codable, Sendable {
    public let milliseconds: Int64

    public init(milliseconds: Int64) {
        self.milliseconds = milliseconds
    }

    // MARK: - Static factories

    public static func milliseconds(_ millis: Int64) -> SyzygyDuration {
        SyzygyDuration(milliseconds: millis)
    }

    public static func seconds(_ sec: Double) -> SyzygyDuration {
        SyzygyDuration(milliseconds: Int64(sec * 1000))
    }

    public static func minutes(_ min: Double) -> SyzygyDuration {
        SyzygyDuration(milliseconds: Int64(min * 60_000))
    }

    public static func hours(_ hrs: Double) -> SyzygyDuration {
        SyzygyDuration(milliseconds: Int64(hrs * 3_600_000))
    }

    // MARK: - Computed

    public var seconds: Double { Double(milliseconds) / 1000.0 }
    public var minutes: Double { Double(milliseconds) / 60_000.0 }
    public var hours: Double { Double(milliseconds) / 3_600_000.0 }

    public static func < (lhs: SyzygyDuration, rhs: SyzygyDuration) -> Bool {
        lhs.milliseconds < rhs.milliseconds
    }
}

import SyzygyFoundation

/// A deterministic TimeProvider for use in tests.
public final class FixedTimeProvider: TimeProvider, @unchecked Sendable {
    public var fixedTime: SyzygyTimestamp

    public init(fixedTime: SyzygyTimestamp = SyzygyTimestamp(millisecondsSinceEpoch: 0)) {
        self.fixedTime = fixedTime
    }

    public func now() -> SyzygyTimestamp { fixedTime }

    public func since(_ timestamp: SyzygyTimestamp) -> SyzygyDuration {
        .milliseconds(fixedTime.millisecondsSinceEpoch - timestamp.millisecondsSinceEpoch)
    }
}

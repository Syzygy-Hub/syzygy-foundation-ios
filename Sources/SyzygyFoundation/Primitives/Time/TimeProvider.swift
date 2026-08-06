/// Protocol for time abstraction. Implementations live in Core (e.g. SystemTimeProvider).
public protocol TimeProvider: Sendable {
    func now() -> SyzygyTimestamp
    func since(_ timestamp: SyzygyTimestamp) -> SyzygyDuration
}

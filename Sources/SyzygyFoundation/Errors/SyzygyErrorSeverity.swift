/// Severity level for a SyzygyError.
public enum SyzygyErrorSeverity: Int, Equatable, Comparable, Codable, Sendable {
    case info = 0
    case warning = 1
    case error = 2
    case critical = 3

    public static func < (lhs: SyzygyErrorSeverity, rhs: SyzygyErrorSeverity) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

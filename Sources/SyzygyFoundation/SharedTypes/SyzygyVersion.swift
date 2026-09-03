/// A semantic version with Comparable and CustomStringConvertible support.
///
/// Comparison ignores `prerelease` for simplicity.
public struct SyzygyVersion: Equatable, Comparable, Codable, CustomStringConvertible, Sendable {
    public let major: Int
    public let minor: Int
    public let patch: Int
    public let prerelease: String?

    public init(_ major: Int, _ minor: Int, _ patch: Int, prerelease: String? = nil) {
        self.major = major
        self.minor = minor
        self.patch = patch
        self.prerelease = prerelease
    }

    /// The Foundation library version.
    public static let current = SyzygyVersion(1, 1, 0)

    /// Returns e.g. `"1.2.3"` or `"1.2.3-beta"`.
    public var description: String {
        let base = "\(major).\(minor).\(patch)"
        if let pre = prerelease { return "\(base)-\(pre)" }
        return base
    }

    public static func < (lhs: SyzygyVersion, rhs: SyzygyVersion) -> Bool {
        if lhs.major != rhs.major { return lhs.major < rhs.major }
        if lhs.minor != rhs.minor { return lhs.minor < rhs.minor }
        return lhs.patch < rhs.patch
    }
}

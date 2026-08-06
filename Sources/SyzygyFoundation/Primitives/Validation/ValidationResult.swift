/// The result of applying a validation rule to a value.
public enum ValidationResult: Equatable, Sendable {
    case valid
    case invalid(messages: [String])

    /// True when validation passed.
    public var isValid: Bool {
        if case .valid = self { return true }
        return false
    }

    /// Returns validation failure messages, or an empty array when valid.
    public var messages: [String] {
        if case .invalid(let msgs) = self { return msgs }
        return []
    }
}

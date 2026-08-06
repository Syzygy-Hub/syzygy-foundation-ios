/// A protocol for types that can validate a value and return a ValidationResult.
public protocol ValidationRule: Sendable {
    func validate<T>(_ value: T) -> ValidationResult
}

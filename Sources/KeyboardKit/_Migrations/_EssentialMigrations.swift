import Foundation

public extension Keyboard.KeyboardType {

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Keyboard type and case have been separated.")
    static func alphabetic(_ case: Keyboard.Case) -> Self {
        .alphabetic
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Just use an equality check.")
    var isAlphabetic: Bool {
        self == .alphabetic
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Keyboard type and case have been separated.")
    var isAlphabeticCapsLocked: Bool {
        self == .alphabetic
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Keyboard type and case have been separated.")
    var isAlphabeticUppercased: Bool {
        self == .alphabetic
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Keyboard type and case have been separated.")
    func isAlphabetic(_ case: Keyboard.Case) -> Bool {
        self == .alphabetic
    }
}

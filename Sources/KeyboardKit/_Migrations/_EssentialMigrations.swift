import Foundation

public extension Keyboard {

    @available(*, deprecated, renamed: "KeyboardCase", message: "Migration Deprecation, will be removed in 9.1!")
    typealias Case = KeyboardCase
}

public extension Keyboard.KeyboardType {

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Keyboard type and case have been separated.")
    static func alphabetic(_ case: Keyboard.KeyboardCase) -> Self {
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
    func isAlphabetic(_ case: Keyboard.KeyboardCase) -> Bool {
        self == .alphabetic
    }
}

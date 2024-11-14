import Foundation

public extension KeyboardAction {

    @available(*, deprecated, renamed: "shift(_:)", message: "Migration Deprecation, will be removed in 9.1!")
    static func shift(currentCasing: Keyboard.KeyboardCase) -> KeyboardAction {
        .shift(currentCasing)
    }

    @available(*, deprecated, renamed: "accessibilityLabel", message: "Migration Deprecation, will be removed in 9.1!")
    var standardAccessibilityLabel: String? {
        accessibilityLabel
    }
}

@available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Copy it if you need it.")
public extension Array where Element == KeyboardAction {
    
    func evened(for columns: Int) -> [KeyboardAction] {
        var actions = self
        while actions.count % columns > 0 {
            actions.append(.none)
        }
        return actions
    }
}

public extension KeyboardAction.StandardHandler {

    @available(*, deprecated, renamed: "behavior", message: "Migration Deprecation, will be removed in 9.1!")
    var keyboardBehavior: KeyboardBehavior {
        behavior
    }
}

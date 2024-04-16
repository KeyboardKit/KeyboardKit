import Foundation

public extension KeyboardLayout {
    
    @available(*, deprecated, renamed: "hasKeyboardSwitcher(_:)")
    func hasKeyboardSwitcher(for type: Keyboard.KeyboardType) -> Bool {
        itemRows.hasKeyboardSwitcher(type)
    }
    
}

@available(*, deprecated, renamed: "KeyboardLayoutRowIdentifiable")
public typealias KeyboardLayoutRowItem = KeyboardLayoutRowIdentifiable

@available(*, deprecated, renamed: "KeyboardLayoutIdentifiable")
public typealias KeyboardLayoutRowIdentifiable = KeyboardLayoutIdentifiable

import Foundation

public extension KeyboardAction {
    
    @available(*, deprecated, renamed: "diacritic(_:)")
    static func accent(
        _ accent: Keyboard.Accent
    ) -> KeyboardAction {
        .diacritic(accent)
    }
}

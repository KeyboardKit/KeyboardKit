import SwiftUI

public extension KeyboardAction {
    
    @available(*, deprecated, renamed: "standardButtonBackgroundColor")
    func systemKeyboardButtonBackgroundColor(for context: KeyboardContext) -> Color {
        standardButtonBackgroundColor(for: context)
    }
    
    @available(*, deprecated, renamed: "standardButtonImage")
    func systemKeyboardButtonImage(for context: KeyboardContext) -> Image? {
        standardButtonImage(for: context)
    }
    
    @available(*, deprecated, renamed: "standardButtonShadowColor")
    func systemKeyboardButtonShadowColor(for context: KeyboardContext) -> Color {
        standardButtonShadowColor(for: context)
    }
}

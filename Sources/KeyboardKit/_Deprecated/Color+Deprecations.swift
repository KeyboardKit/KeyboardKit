import KeyboardKit
import SwiftUI

public extension Color {
    
    @available(*, deprecated, renamed: "standardDarkButton")
    static func systemKeyboardButtonBackgroundColorDark(for context: KeyboardContext) -> Color { standardDarkButton(for: context) }
    
    @available(*, deprecated, renamed: "standardButton")
    static func systemKeyboardButtonBackgroundColorLight(for context: KeyboardContext) -> Color { standardButton(for: context) }
    
    @available(*, deprecated, renamed: "standardButtonTint")
    static func systemKeyboardButtonForegroundColor(for context: KeyboardContext) -> Color { standardButtonTint(for: context) }
    
    @available(*, deprecated, renamed: "standardButtonShadowColor")
    static func systemKeyboardButtonShadowColor(for context: KeyboardContext) -> Color { standardButtonShadowColor(for: context) }
}

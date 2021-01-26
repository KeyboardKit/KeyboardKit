import KeyboardKit
import SwiftUI

public extension View {
    
    @available(*, deprecated, message: "use keyboardAction(:actionHandler:) instead")
    func keyboardAction(_ action: KeyboardAction, context: KeyboardContext) -> some View {
        keyboardAction(action, actionHandler: context.actionHandler)
    }
    
    @available(*, deprecated, renamed: "standardButtonStyle")
    func systemKeyboardButtonStyle(for action: KeyboardAction, context: KeyboardContext, cornerRadius: CGFloat = 4.0) -> some View {
        standardButtonStyle(for: action, context: context, cornerRadius: cornerRadius)
    }
    
    @available(*, deprecated, renamed: "standardButtonBackground")
    func systemKeyboardButtonBackground(for action: KeyboardAction, context: KeyboardContext) -> some View {
        standardButtonBackground(for: action, context: context)
    }
    
    @available(*, deprecated, renamed: "standardButtonFont")
    func systemKeyboardButtonFont(for action: KeyboardAction, context: KeyboardContext) -> some View {
        standardButtonFont(for: action, context: context)
    }
    
    @available(*, deprecated, renamed: "standardButtonForeground")
    func systemKeyboardButtonForeground(for context: KeyboardContext) -> some View {
        standardButtonForeground(for: context)
    }
    
    @available(*, deprecated, renamed: "standardButtonShadow")
    func systemKeyboardButtonShadow(for context: KeyboardContext) -> some View {
        standardButtonShadow(for: context)
    }
}

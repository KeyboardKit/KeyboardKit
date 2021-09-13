import SwiftUI

public extension View {
    
    @available(*, deprecated, renamed: "systemKeyboardButtonStyle")
    func keyboardButtonStyle(
        for action: KeyboardAction,
        appearance: KeyboardAppearance,
        isPressed: Bool = false) -> some View {
            self.systemKeyboardButtonStyle(
                appearance.systemKeyboardButtonStyle(for: action, isPressed: isPressed)
            )
        }
}

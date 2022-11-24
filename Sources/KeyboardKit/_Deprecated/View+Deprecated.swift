import SwiftUI

extension View {
    
    @ViewBuilder
    @available(*, deprecated, message: "context is no longer needed")
    func keyboardGestures(
        for action: KeyboardAction,
        context: KeyboardContext,
        actionHandler: KeyboardActionHandler,
        isPressed: Binding<Bool> = .constant(false)
    ) -> some View {
        self.keyboardGestures(
            for: action,
            actionHandler: actionHandler,
            isPressed: isPressed)
    }
}

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

    @ViewBuilder
    @available(*, deprecated, message: "Use KeyboardContext-based extension instead.")
    func localeContextMenu<ButtonView: View>(
        locales: [Locale],
        buttonViewBuilder: @escaping (Locale) -> ButtonView
    ) -> some View {
        if locales.count < 2 {
            self
        } else {
            self.contextMenu(
                ContextMenu {
                    ForEach(locales, id: \.identifier) {
                        buttonViewBuilder($0)
                    }
                }
            )
        }
    }
}

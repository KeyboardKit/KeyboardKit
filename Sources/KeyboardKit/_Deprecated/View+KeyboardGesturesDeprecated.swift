import SwiftUI

public extension View {

    @ViewBuilder
    @available(*, deprecated, renamed: "keyboardButtonGestures")
    func keyboardGestures(
        for action: KeyboardAction,
        actionHandler: KeyboardActionHandler,
        calloutContext: KeyboardCalloutContext?,
        isInScrollView: Bool = false,
        isPressed: Binding<Bool> = .constant(false)
    ) -> some View {
        self.keyboardButtonGestures(
            for: action,
            actionHandler: actionHandler,
            calloutContext: calloutContext,
            isPressed: isPressed,
            isInScrollView: isInScrollView
        )
    }

    @ViewBuilder
    @available(*, deprecated, renamed: "keyboardButtonGestures")
    func keyboardGestures(
        action: KeyboardAction? = nil,
        calloutContext: KeyboardCalloutContext?,
        isInScrollView: Bool = false,
        isPressed: Binding<Bool> = .constant(false),
        doubleTapAction: KeyboardGestureAction? = nil,
        longPressAction: KeyboardGestureAction? = nil,
        pressAction: KeyboardGestureAction? = nil,
        releaseAction: KeyboardGestureAction? = nil,
        repeatAction: KeyboardGestureAction? = nil,
        dragAction: KeyboardDragGestureAction? = nil
    ) -> some View {
        self.keyboardButtonGestures(
            action: action,
            calloutContext: calloutContext,
            isPressed: isPressed,
            isInScrollView: isInScrollView,
            doubleTapAction: doubleTapAction,
            longPressAction: longPressAction,
            pressAction: pressAction,
            releaseAction: releaseAction,
            repeatAction: repeatAction,
            dragAction: dragAction
        )
    }
}

#if os(iOS) || os(macOS) || os(watchOS) || os(visionOS)
import SwiftUI

public extension GestureButton {
    
    @_disfavoredOverload
    @available(*, deprecated, message: "Use the .gestureButtonConfiguration(...) view modifier instead.")
    init(
        isPressed: Binding<Bool>? = nil,
        scrollState: GestureButtonScrollState? = nil,
        pressAction: Action? = nil,
        cancelDelay: TimeInterval? = nil,
        releaseInsideAction: Action? = nil,
        releaseOutsideAction: Action? = nil,
        longPressDelay: TimeInterval? = nil,
        longPressAction: Action? = nil,
        doubleTapTimeout: TimeInterval? = nil,
        doubleTapAction: Action? = nil,
        repeatDelay: TimeInterval? = nil,
        repeatTimer: GestureButtonTimer? = nil,
        repeatAction: Action? = nil,
        dragStartAction: DragAction? = nil,
        dragAction: DragAction? = nil,
        dragEndAction: DragAction? = nil,
        endAction: Action? = nil,
        label: @escaping LabelBuilder
    ) {
        self.init(
            config: .init(
                cancelDelay: cancelDelay,
                doubleTapTimeout: doubleTapTimeout,
                longPressDelay: longPressDelay,
                repeatDelay: repeatDelay
            ),
            isPressed: isPressed,
            scrollState: scrollState,
            pressAction: pressAction,
            releaseInsideAction: releaseInsideAction,
            releaseOutsideAction: releaseOutsideAction,
            longPressAction: longPressAction,
            doubleTapAction: doubleTapAction,
            repeatTimer: repeatTimer,
            repeatAction: repeatAction,
            dragStartAction: dragStartAction,
            dragAction: dragAction,
            dragEndAction: dragEndAction,
            endAction: endAction,
            label: label
        )
    }
}
#endif

import Foundation

public extension StandardKeyboardActionHandler {

    @available(*, deprecated, message: "Use the function without keyboardContext instead.")
    static func dragGestureHandler(
        keyboardController: KeyboardController,
        keyboardContext: KeyboardContext,
        keyboardFeedbackHandler: KeyboardFeedbackHandler,
        spaceDragSensitivity: SpaceDragSensitivity
    ) -> SpaceCursorDragGestureHandler {
        weak var controller = keyboardController
        return .init(
            feedbackHandler: keyboardFeedbackHandler,
            sensitivity: spaceDragSensitivity,
            action: { controller?.adjustTextPosition(byCharacterOffset: $0) }
        )
    }
}

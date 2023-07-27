import Foundation

public extension StandardKeyboardActionHandler {

    @available(*, deprecated, message: "Use the function without a feedback handler")
    static func dragGestureHandler(
        keyboardController: KeyboardController,
        keyboardContext: KeyboardContext,
        keyboardFeedbackHandler: KeyboardFeedbackHandler,
        spaceDragSensitivity: SpaceDragSensitivity
    ) -> SpaceCursorDragGestureHandler {
        weak var controller = keyboardController
        weak var context = keyboardContext
        return .init(
            feedbackHandler: keyboardFeedbackHandler,
            sensitivity: spaceDragSensitivity,
            action: {
                let offset = context?.textDocumentProxy.spaceDragOffset(for: $0)
                controller?.adjustTextPosition(byCharacterOffset: offset ?? $0)
            }
        )
    }
}

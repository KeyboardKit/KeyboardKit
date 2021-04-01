import Foundation

public extension StandardKeyboardActionHandler {
    
    @available(*, deprecated, message: "Use the new keyboardFeedbackHandler")
    var audioConfiguration: AudioFeedbackConfiguration {
        (keyboardFeedbackHandler as? StandardKeyboardFeedbackHandler)?.audioConfig ?? .standard
    }
    
    @available(*, deprecated, message: "Use the new keyboardFeedbackHandler")
    var hapticConfiguration: HapticFeedbackConfiguration {
        (keyboardFeedbackHandler as? StandardKeyboardFeedbackHandler)?.hapticConfig ?? .standard
    }
    
    @available(*, deprecated, message: "Use the new spaceDragGestureHandler instead.")
    var spaceDragSensitivity: SpaceDragSensitivity {
        (spaceDragGestureHandler as? SpaceCursorDragGestureHandler)?.sensitivity ?? .medium
    }
}

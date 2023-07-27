import Foundation

@available(*, deprecated, message: "This protocol is replaced by KeyboardActionHandler")
public protocol KeyboardFeedbackHandler {
    
    func triggerFeedback(
        for gesture: KeyboardGesture,
        on action: KeyboardAction
    )
 
    func triggerAudioFeedback(
        for gesture: KeyboardGesture,
        on action: KeyboardAction
    )
    
    func triggerHapticFeedback(
        for gesture: KeyboardGesture,
        on action: KeyboardAction
    )
}

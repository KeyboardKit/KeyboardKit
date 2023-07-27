import Foundation

@available(*, deprecated, message: "Use settings directly instead")
public extension StandardKeyboardFeedbackHandler {
    
    var audioConfig: AudioFeedbackConfiguration { settings.audioConfiguration }
    
    var hapticConfig: HapticFeedbackConfiguration { settings.hapticConfiguration }
}

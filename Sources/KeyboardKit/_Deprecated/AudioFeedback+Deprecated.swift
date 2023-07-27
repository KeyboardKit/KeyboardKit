import Foundation

public extension AudioFeedback {
    
    @available(*, deprecated, message: "This property is no longer used")
    static var engine: AudioFeedbackEngine = {
        #if os(iOS) || os(macOS) || os(tvOS)
        StandardAudioFeedbackEngine.shared
        #else
        DisabledAudioFeedbackEngine()
        #endif
    }()
}

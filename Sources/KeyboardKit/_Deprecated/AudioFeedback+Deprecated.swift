import Foundation

public extension AudioFeedback {
    
    /**
     The engine that will be used to trigger audio feedback.
     */
    @available(*, deprecated, message: "This property is no longer used")
    static var engine: AudioFeedbackEngine = {
        #if os(iOS) || os(macOS) || os(tvOS)
        StandardAudioFeedbackEngine.shared
        #else
        DisabledAudioFeedbackEngine()
        #endif
    }()
}

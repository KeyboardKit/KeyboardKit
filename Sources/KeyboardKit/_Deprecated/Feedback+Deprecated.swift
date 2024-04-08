import Foundation

@available(*, deprecated, renamed: "Feedback.Audio")
public typealias AudioFeedback = Feedback.Audio

@available(*, deprecated, renamed: "Feedback.Haptic")
public typealias HapticFeedback = Feedback.Haptic

@available(*, deprecated, renamed: "FeedbackContext")
public typealias FeedbackConfiguration = FeedbackContext

public extension Feedback.Audio {
    
    @available(*, deprecated, renamed: "Feedback.AudioConfiguration")
    typealias Configuration = Feedback.AudioConfiguration
    
    @available(*, deprecated, renamed: "Feedback.AudioEngine")
    typealias Engine = Feedback.AudioEngine
    
    @available(*, deprecated, renamed: "customId(_:)")
    static func custom(id: UInt32) -> AudioFeedback {
        customId(id)
    }
}

public extension Feedback.Haptic {
    
    @available(*, deprecated, renamed: "Feedback.HapticConfiguration")
    typealias Configuration = Feedback.HapticConfiguration
    
    @available(*, deprecated, renamed: "Feedback.HapticEngine")
    typealias Engine = Feedback.HapticEngine
}

public extension Keyboard.State {
    
    @available(*, deprecated, renamed: "feedbackContext")
    var feedbackConfiguration: FeedbackContext {
        get { feedbackContext }
        set { feedbackContext = newValue }
    }
}

import Foundation

@available(*, deprecated, renamed: "AudioFeedback")
public typealias SystemAudio = AudioFeedback

@available(*, deprecated, renamed: "AudioFeedbackPlayer")
public typealias SystemAudioPlayer = AudioFeedbackPlayer

@available(*, deprecated, renamed: "StandardAudioFeedbackPlayer")
public typealias StandardSystemAudioPlayer = StandardAudioFeedbackPlayer

@available(*, deprecated, renamed: "DisabledAudioFeedbackPlayer")
public typealias DisabledSystemAudioPlayer = DisabledAudioFeedbackPlayer

public extension AudioFeedback {

    @available(*, deprecated, renamed: "trigger")
    func play() { trigger() }
}

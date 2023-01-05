import Foundation


@available(*, deprecated, renamed: "AudioFeedback")
public typealias SystemAudio = AudioFeedback

@available(*, deprecated, renamed: "AudioFeedbackEngine")
public typealias SystemAudioPlayer = AudioFeedbackEngine

#if os(iOS) || os(macOS) || os(tvOS)
@available(*, deprecated, renamed: "StandardAudioFeedbackEngine")
public typealias StandardSystemAudioPlayer = StandardAudioFeedbackEngine
#endif

@available(*, deprecated, renamed: "DisabledAudioFeedbackEngine")
public typealias DisabledSystemAudioPlayer = DisabledAudioFeedbackEngine

public extension AudioFeedback {

    @available(*, deprecated, renamed: "engine")
    static var player: AudioFeedbackEngine {
        get { engine }
        set { engine = newValue }
    }

    @available(*, deprecated, renamed: "trigger")
    func play() { trigger() }
}

public extension AudioFeedbackEngine {

    @available(*, deprecated, renamed: "trigger")
    func play(_ feedback: AudioFeedback) { trigger(feedback) }
}



@available(*, deprecated, renamed: "HapticFeedbackEngine")
public typealias HapticFeedbackPlayer = HapticFeedbackEngine

#if os(iOS)
@available(*, deprecated, renamed: "StandardHapticFeedbackEngine")
public typealias StandardHapticFeedbackPlayer = StandardHapticFeedbackEngine
#endif

@available(*, deprecated, renamed: "DisabledHapticFeedbackEngine")
public typealias DisabledHapticFeedbackPlayer = DisabledAudioFeedbackEngine

public extension HapticFeedback {

    @available(*, deprecated, renamed: "engine")
    static var player: HapticFeedbackEngine {
        get { engine }
        set { engine = newValue }
    }
}

public extension HapticFeedbackEngine {

    @available(*, deprecated, renamed: "trigger")
    func play(_ feedback: HapticFeedback) { trigger(feedback) }
}

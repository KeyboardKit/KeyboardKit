import Foundation

@available(*, deprecated, message: "This engine is no longer used.")
public class DisabledAudioFeedbackEngine: AudioFeedbackEngine {

    public override func trigger(_ audio: AudioFeedback) {}
}

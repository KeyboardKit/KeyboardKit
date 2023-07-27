#if os(iOS) || os(macOS) || os(tvOS)
import AudioToolbox

@available(*, deprecated, renamed: "AudioFeedbackEngine")
open class StandardAudioFeedbackEngine: AudioFeedbackEngine {}
#endif

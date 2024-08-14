import Foundation

#if os(iOS) || os(macOS) || os(tvOS) || os(visionOS)
import AudioToolbox
#endif

@available(*, deprecated, message: "Use a feedback service or action handler instead")
public extension Feedback {
    
    class AudioEngine {

        public init() {}
        
        func trigger(_ audio: Feedback.Audio) {
            switch audio {
            case .none: return
            case .customUrl(let url): playAudio(at: url)
            default: play(audio)
            }
        }

        static var shared = Feedback.AudioEngine()
    }
}

@available(*, deprecated, message: "Use a feedback service or action handler instead")
private extension Feedback.AudioEngine {
    
    static var systemSoundIDs: [URL: SystemSoundID] = [:]
    
    func play(_ audio: Feedback.Audio) {
        guard let id = audio.id else { return }
        #if os(iOS) || os(macOS) || os(tvOS)
        AudioServicesPlaySystemSound(id)
        #endif
    }
    
    func playAudio(at url: URL?) {
        guard let url else { return }
        #if os(iOS) || os(macOS) || os(tvOS)
        registerAudio(at: url)
        guard let id = Self.systemSoundIDs[url] else { return }
        AudioServicesPlaySystemSound(id)
        #endif
    }
    
    func registerAudio(at url: URL?) {
        guard let url else { return }
        #if os(iOS) || os(macOS) || os(tvOS)
        if Self.systemSoundIDs[url] != nil { return }
        var soundId: SystemSoundID = .init()
        AudioServicesCreateSystemSoundID(url as CFURL, &soundId)
        Self.systemSoundIDs[url] = soundId
        #endif
    }
}

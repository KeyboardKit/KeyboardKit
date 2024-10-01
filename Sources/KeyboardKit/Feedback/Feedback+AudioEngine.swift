import Foundation

#if os(iOS) || os(macOS) || os(tvOS) || os(visionOS)
import AudioToolbox
#else
typealias SystemSoundID = Int
#endif

public extension Feedback {

    /// This engine can be used to trigger audio feedback.
    ///
    /// The engine uses `AudioToolbox`, which is unavailable
    /// on watchOS. Therefore, watchOS has no audio feedback.
    class AudioEngine {

        public init() {}
        
        func trigger(_ audio: Feedback.Audio) {
            switch audio {
            case .none: return
            case .customUrl(let url): playAudio(at: url)
            default: play(audio)
            }
        }
    }
}

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

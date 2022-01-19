import Foundation

public extension SystemAudioPlayer {
    
    @available(*, deprecated, renamed: "play")
    func playSystemAudio(_ audio: SystemAudio) {
        play(audio)
    }
}

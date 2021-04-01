public extension AudioFeedback {
    
    @available(*, deprecated, renamed: "player")
    static var systemPlayer: SystemAudioPlayer {
        get { player }
        set { player = newValue }
    }
}

//
//  AudioFeedback+Engine.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-15.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS) || os(tvOS)
import AudioToolbox
#endif

public extension AudioFeedback {
    
    /// This engine can be used to trigger audio feedback.
    ///
    /// The engine uses `AudioToolbox`, which is unavailable
    /// on watchOS. Therefore, watchOS has no audio feedback.
    class Engine {
        
        /// Create an audio feedback engine instance.
        public init() {}
        
        /// Trigger a certain audio feedback type.
        func trigger(_ audio: AudioFeedback) {
            switch audio {
            case .none: return
            case .customUrl(let url): playAudio(at: url)
            default: play(audio)
            }
        }
    }
}


public extension AudioFeedback.Engine {
    
    /// This shared instance can be used from anywhere.
    static var shared = AudioFeedback.Engine()
}

private extension AudioFeedback.Engine {
    
    static var systemSoundIDs: [URL: SystemSoundID] = [:]
    
    func play(_ audio: AudioFeedback) {
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

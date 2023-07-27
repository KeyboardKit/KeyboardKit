//
//  AudioFeedbackEngine.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-15.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS) || os(tvOS)
import AudioToolbox
#endif

/**
 This engine uses system features to trigger audio feedback.
 */
open class AudioFeedbackEngine {
    
    /**
     Create an audio feedback instance.
     */
    public init() {}
    
    /**
     Trigger a certain audio feedback type.
     **/
    open func trigger(_ audio: AudioFeedback) {
        switch audio {
        case .none: return
        default: play(audio)
        }
    }
}

public extension AudioFeedbackEngine {
    
    /**
     A shared instance that can be used from anywhere.
     */
    static var shared = AudioFeedbackEngine()
}

private extension AudioFeedbackEngine {
    
    func play(_ audio: AudioFeedback) {
        #if os(iOS) || os(macOS) || os(tvOS)
        AudioServicesPlaySystemSound(audio.id)
        #endif
    }
}

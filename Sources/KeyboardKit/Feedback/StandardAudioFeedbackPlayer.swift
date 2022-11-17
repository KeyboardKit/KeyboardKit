//
//  StandardAudioFeedbackPlayer.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS) || os(tvOS)
import AudioToolbox

/**
 This player uses system features to play audio feedback. It
 is the default ``AudioFeedback/player`` on all platforms on
 which it's supported.

 You can use, modify and replace the ``shared`` player. This
 lets you customize the global audio feedback experience.
 
 Note that the player is currently only supported on certain
 platforms.
 */
open class StandardAudioFeedbackPlayer: AudioFeedbackPlayer {
    
    public init() {}
    
    /**
     Play a certain audio feedback type.
     **/
    open func play(_ audio: AudioFeedback) {
        switch audio {
        case .none: return
        default: AudioServicesPlaySystemSound(audio.id)
        }
    }
}

public extension StandardAudioFeedbackPlayer {
    
    /**
     A shared instance that can be used from anywhere.
     */
    static var shared = StandardAudioFeedbackPlayer()
}
#endif

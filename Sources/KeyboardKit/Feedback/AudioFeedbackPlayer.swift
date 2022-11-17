//
//  AudioFeedbackPlayer.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any classes that can be
 used to play audio feedback.
 */
public protocol AudioFeedbackPlayer {
    
    /**
     Play a certain audio feedback type.
     **/
    func play(_ audio: AudioFeedback)
}

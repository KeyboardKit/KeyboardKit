//
//  DisabledAudioFeedbackPlayer.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-01-19.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This disabled player doesn't do anything and can be used on
 platforms where system audio is not available.
 */
public class DisabledAudioFeedbackPlayer: AudioFeedbackPlayer {

    public func play(_ audio: AudioFeedback) {}
}

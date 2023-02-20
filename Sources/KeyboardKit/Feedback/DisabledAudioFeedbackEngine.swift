//
//  DisabledAudioFeedbackEngine.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-01-19.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This disabled engine doesn't do anything and can be used on
 platforms where system audio is not available.
 */
public class DisabledAudioFeedbackEngine: AudioFeedbackEngine {

    /**
     Create a disabled engine.
     */
    public init() {}
    
    public func trigger(_ audio: AudioFeedback) {}
}

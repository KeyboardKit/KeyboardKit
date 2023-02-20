//
//  AudioFeedbackEngine.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-15.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any classes that can be
 used to trigger audio feedback.
 */
public protocol AudioFeedbackEngine {
    
    /**
     Trigger a certain audio feedback type.
     **/
    func trigger(_ audio: AudioFeedback)
}

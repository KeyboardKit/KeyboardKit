//
//  KeyboardFeedbackHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

@available(*, deprecated, message: "This protocol is replaced by KeyboardActionHandler")
public protocol KeyboardFeedbackHandler {
    
    /**
     Trigger feedback for a certain keyboard action gesture.
     */
    func triggerFeedback(
        for gesture: KeyboardGesture,
        on action: KeyboardAction
    )
 
    /**
     Trigger feedback for a certain keyboard action gesture.
     */
    func triggerAudioFeedback(
        for gesture: KeyboardGesture,
        on action: KeyboardAction
    )
    
    /**
     Trigger feedback for a certain keyboard action gesture.
     */
    func triggerHapticFeedback(
        for gesture: KeyboardGesture,
        on action: KeyboardAction
    )
}

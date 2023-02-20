//
//  KeyboardFeedbackHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any classes that can be
 used to trigger audio and haptic feedback to the user.
 
 KeyboardKit will create a ``StandardKeyboardFeedbackHandler``
 instance when the keyboard extension is started, then apply
 it to ``KeyboardInputViewController/keyboardFeedbackHandler``.
 It will then use this instance by default to give feedback.
 
 Many keyboard actions have standard feedbacks, while others
 don't and require custom handling. To customize how actions
 give feedback, you can implement a custom feedback handler.
 
 You can create a custom implementation of this protocol, by
 inheriting and customizing the standard class or creating a
 new implementation from scratch. When you're implementation
 is ready, just replace the controller service with your own
 implementation to make the library use it instead.
 */
public protocol KeyboardFeedbackHandler {
    
    /**
     Trigger feedback for when a `gesture` is performed on a
     certain `action`.
     */
    func triggerFeedback(for gesture: KeyboardGesture, on action: KeyboardAction)
 
    /**
     Trigger feedback for when a `gesture` is performed on a
     certain `action`.
     */
    func triggerAudioFeedback(for gesture: KeyboardGesture, on action: KeyboardAction)
    
    /**
     Trigger feedback for when a `gesture` is performed on a
     certain `action`.
     */
    func triggerHapticFeedback(for gesture: KeyboardGesture, on action: KeyboardAction)
}

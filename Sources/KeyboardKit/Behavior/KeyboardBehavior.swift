//
//  KeyboardBehavior.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be used to specify behavior rules for the
 keyboard. It aims to separate behavior from action handling
 to make the code cleaner and more understandable.
 
 KeyboardKit automatically creates an implementation of this
 protocol and binds it to ``KeyboardInputViewController``.
 
 `IMPORTANT` Whenever you replace the standard behavior with
 your own custom behavior, make sure to do so before calling
 any other services that depend on the behavior, or recreate
 the services that do depend on it.
 */
public protocol KeyboardBehavior {
    
    /**
     The range that backspace should delete when it's repeat
     pressed. Standard keyboards start increasing from chars
     to words after a little while.
     */
    var backspaceRange: DeleteBackwardRange { get }
    
    /**
     The preferred keyboard type that should be applied when
     the provided action has been performed.
     */
    func preferredKeyboardType(
        after gesture: KeyboardGesture,
        on action: KeyboardAction) -> KeyboardType
    
    /**
     Whether or not the active sentence should be ended when
     the provided action has been performed.
     */
    func shouldEndSentence(
        after gesture: KeyboardGesture,
        on action: KeyboardAction) -> Bool
    
    /**
     Whether or not the keyboard should switch to a capslock
     state after a gesture on an action.
     */
    func shouldSwitchToCapsLock(
        after gesture: KeyboardGesture,
        on action: KeyboardAction) -> Bool
    
    /**
     Whether or not the current keyboard type should be auto
     switched to the behavior's preferred keyboard type when
     the provided action has been performed.
     */
    func shouldSwitchToPreferredKeyboardType(
        after gesture: KeyboardGesture,
        on action: KeyboardAction) -> Bool

    /**
     Whether or not the current keyboard type should be auto
     switched to the behavior's preferred keyboard type when
     the text document proxy's text did change.
     */
    func shouldSwitchToPreferredKeyboardTypeAfterTextDidChange() -> Bool
}

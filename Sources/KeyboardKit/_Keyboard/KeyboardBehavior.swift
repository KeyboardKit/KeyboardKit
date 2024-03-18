//
//  KeyboardBehavior.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by classes that can define
 keyboard-specific behaviors.
 
 KeyboardKit will inject a ``StandardKeyboardBehavior`` into
 ``KeyboardInputViewController/services`` then use it as the
 the default keyboard behavior.
 
 To change how your keyboard behaves, you can implement your
 own, custom behavior.

 To create a custom implementation of this protocol, you can
 either implement the protocol from scratch, or subclass the
 standard class and override what you want to change. Inject
 it into ``KeyboardInputViewController/services`` to make it
 be used as the global default.
 */
public protocol KeyboardBehavior {
    
    typealias Gesture = Gestures.KeyboardGesture
    
    /// The range that backspace should delete.
    var backspaceRange: Keyboard.BackspaceRange { get }
    
    /// The preferred keyboard type after an action gesture.
    func preferredKeyboardType(
        after gesture: Gesture,
        on action: KeyboardAction
    ) -> Keyboard.KeyboardType
    
    /// Whether to end the sentence after a gesture action.
    func shouldEndSentence(
        after gesture: Gesture,
        on action: KeyboardAction
    ) -> Bool
    
    /// Whether to switch to capslock after a gesture action.
    func shouldSwitchToCapsLock(
        after gesture: Gesture,
        on action: KeyboardAction
    ) -> Bool
    
    /// Whether to switch to the preferred keyboard type after
    /// a gesture action.
    func shouldSwitchToPreferredKeyboardType(
        after gesture: Gesture,
        on action: KeyboardAction
    ) -> Bool

    /// Whether to switch to a preferred keyboard type after
    /// the text document proxy text changes.
    func shouldSwitchToPreferredKeyboardTypeAfterTextDidChange() -> Bool
}

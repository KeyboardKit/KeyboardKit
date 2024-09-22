//
//  KeyboardBehavior.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This protocol can be implemented by any classes that can
/// define keyboard-specific behaviors.
///
/// Some types, like ``KeyboardAction/StandardHandler`` will
/// use this protocol to make certain decisions.
///
/// KeyboardKit will automatically setup a standard protocol
/// implementation in ``KeyboardInputViewController/services``
/// when the keyboard is launched. You can change or replace
/// it at any time to customize the keyboard behavior.
///
/// See the <doc:Essentials-Article> for more information.
public protocol KeyboardBehavior {
    
    @available(*, deprecated, message: "Just use Keyboard.Gesture from now on")
    typealias Gesture = Keyboard.Gesture
    
    /// The range that backspace should delete.
    var backspaceRange: Keyboard.BackspaceRange { get }
    
    /// The text to use to end sentences with.
    var endSentenceText: String { get set }
    
    /// The preferred keyboard type after an action gesture.
    func preferredKeyboardType(
        after gesture: Keyboard.Gesture,
        on action: KeyboardAction
    ) -> Keyboard.KeyboardType
    
    /// Whether to end the sentence after a gesture action.
    func shouldEndSentence(
        after gesture: Keyboard.Gesture,
        on action: KeyboardAction
    ) -> Bool
    
    /// Whether to switch to capslock after a gesture action.
    func shouldSwitchToCapsLock(
        after gesture: Keyboard.Gesture,
        on action: KeyboardAction
    ) -> Bool
    
    /// Whether to switch to the preferred keyboard type after
    /// a gesture action.
    func shouldSwitchToPreferredKeyboardType(
        after gesture: Keyboard.Gesture,
        on action: KeyboardAction
    ) -> Bool

    /// Whether to switch to a preferred keyboard type after
    /// the text document proxy text changes.
    func shouldSwitchToPreferredKeyboardTypeAfterTextDidChange() -> Bool
}

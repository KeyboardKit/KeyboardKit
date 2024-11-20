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
/// KeyboardKit will automatically setup a standard protocol
/// implementation in ``KeyboardInputViewController/services``
/// when the keyboard is launched. You can change or replace
/// it at any time to customize the keyboard behavior.
///
/// See the <doc:Essentials-Article> for more information.
public protocol KeyboardBehavior {
    
    /// The range that backspace should delete.
    var backspaceRange: Keyboard.BackspaceRange { get }
    
    /// The text to use to end sentences with.
    var endSentenceText: String { get set }

    /// The preferred keyboard case after a certain action gesture.
    func preferredKeyboardCase(
        after gesture: Keyboard.Gesture,
        on action: KeyboardAction
    ) -> Keyboard.KeyboardCase

    /// The preferred keyboard type after a certain action gesture.
    func preferredKeyboardType(
        after gesture: Keyboard.Gesture,
        on action: KeyboardAction
    ) -> Keyboard.KeyboardType

    /// Whether to end the current sentence after a certain action gesture.
    func shouldEndCurrentSentence(
        after gesture: Keyboard.Gesture,
        on action: KeyboardAction
    ) -> Bool

    /// Whether to register an emoji after a certain action gesture.
    func shouldRegisterEmoji(
        after gesture: Keyboard.Gesture,
        on action: KeyboardAction
    ) -> Bool
}

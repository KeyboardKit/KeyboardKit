//
//  KeyboardActionTrigger.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-23.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This protocol can be implemented by any classes that can
/// be used to control a keyboard extension.
///
/// ``KeyboardInputViewController`` implements this protocol
/// by using its text document proxy, state, and services.
public protocol KeyboardController: AnyObject {

    /// Keyboard-specific services.
    var services: Keyboard.Services { get }

    /// Keyboard-specific state.
    var state: Keyboard.State { get }


    /// Adjust the text input cursor position.
    func adjustTextPosition(by characterOffset: Int)

    /// Delete backwards.
    func deleteBackward()

    /// Delete backwards a certain number of times.
    func deleteBackward(times: Int)

    /// Dismiss the keyboard.
    func dismissKeyboard()

    /// End the current sentence with the provided text.
    func endSentence(withText text: String)

    /// Insert the provided diacritic.
    func insertDiacritic(_ diacritic: Keyboard.Diacritic)
    
    /// Insert the provided text.
    func insertText(_ text: String)

    /// Perform an autocomplete operation.
    func performAutocomplete()

    /// Perform a keyboard-initiated dictation operation.
    func performDictation()

    /// Select the next locale, if any.
    func selectNextLocale()

    /// Set a certain keyboard case.
    func setKeyboardCase(_ case: Keyboard.KeyboardCase)

    /// Set a certain keyboard type.
    func setKeyboardType(_ type: Keyboard.KeyboardType)

    /// Open a certain URL
    func openUrl(_ url: URL?)
}

//
//  KeyboardActionTrigger.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-23.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol is used to abstract the input view controller.

 ``KeyboardInputViewController`` implements this protocol by
 calling itself, its document proxy, or its keyboard context.
 */
public protocol KeyboardController: AnyObject {

    /// Adjust the text input cursor position.
    func adjustTextPosition(by characterOffset: Int)

    /// Delete backwards.
    func deleteBackward()

    /// Delete backwards a certain number of times.
    func deleteBackward(times: Int)

    /// Dismiss the keyboard.
    func dismissKeyboard()

    /// Insert the provided text.
    func insertText(_ text: String)

    /// Perform an autocomplete operation.
    func performAutocomplete()

    /// Perform a keyboard-initiated dictation operation.
    func performDictation()

    /// Select the next locale, if any.
    func selectNextLocale()

    /// Set a certain keyboard type.
    func setKeyboardType(_ type: Keyboard.KeyboardType)

    /// Open a certain URL
    func openUrl(_ url: URL?)
}

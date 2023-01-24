//
//  KeyboardActionTrigger.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-23.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol is meant to abstract using the keyboard input
 view controller within the library.

 The protocol currently defines what's currently required to
 make the `KeyboardAction+Actions` extensions depend on this
 protocol instead of ``KeyboardInputViewController``, but it
 may come to add functionality over time.

 The controller could, but perhaps shouldn't, add all of the
 functionality that it can derive from its proxy and context.
 Instead, let's keep the protocol focused instead of risking
 to misuse it.

 ``KeyboardInputViewController`` implements this protocol by
 calling itself, its document proxy, or its keyboard context.
 */
public protocol KeyboardController: AnyObject {

    /**
     Adjust the text input cursor position.
     */
    func adjustTextPosition(byCharacterOffset: Int)

    /**
     Delete backwards.
     */
    func deleteBackward()

    /**
     Delete backwards a certain number of times.
     */
    func deleteBackward(times: Int)

    /**
     Dismiss the keyboard.
     */
    func dismissKeyboard()

    /**
     Insert the provided autocomplete suggestion.
     */
    func insertAutocompleteSuggestion(_ suggestion: AutocompleteSuggestion)

    /**
     Insert the provided text.
     */
    func insertText(_ text: String)

    /**
     Select the next keyboard, if any.
     */
    func selectNextKeyboard()

    /**
     Select the next locale, if any.
     */
    func selectNextLocale()

    /**
     Set a certain keyboard type.
     */
    func setKeyboardType(_ type: KeyboardType)
}


#if os(iOS) || os(tvOS)
extension KeyboardInputViewController: KeyboardController {}

public extension KeyboardInputViewController {

    func adjustTextPosition(byCharacterOffset offset: Int) {
        textDocumentProxy.adjustTextPosition(byCharacterOffset: offset)
    }

    func deleteBackward() {
        textDocumentProxy.deleteBackward(range: keyboardBehavior.backspaceRange)
    }

    func deleteBackward(times: Int) {
        textDocumentProxy.deleteBackward(times: times)
    }

    func insertAutocompleteSuggestion(_ suggestion: AutocompleteSuggestion) {
        textDocumentProxy.insertAutocompleteSuggestion(suggestion)
        keyboardActionHandler.handle(.release, on: .character(""))
    }

    func insertText(_ text: String) {
        textDocumentProxy.insertText(text)
    }

    func selectNextKeyboard() {
        keyboardContext.selectNextLocale()
    }

    func selectNextLocale() {
        keyboardContext.selectNextLocale()
    }

    func setKeyboardType(_ type: KeyboardType) {
        keyboardContext.keyboardType = type
    }
}
#endif

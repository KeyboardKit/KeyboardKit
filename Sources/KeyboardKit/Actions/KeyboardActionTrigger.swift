//
//  KeyboardActionTrigger.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-23.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any types that could be
 used to trigger various keyboard actions.

 This protocol defines what's currently required to make the
 `KeyboardAction+Actions` extensions depend on this protocol
 instead of ``KeyboardInputViewController`` since that class
 is only available on some platforms.

 ``KeyboardInputViewController`` implements this protocol by
 calling itself, its document proxy, or its keyboard context.
 */
public protocol KeyboardActionTrigger {

    /**
     Adjust the text input cursor position.
     */
    func adjustTextPosition(byCharacterOffset: Int)

    /**
     Delete backwards.
     */
    func deleteBackward()

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
     Select the next locale, if any.
     */
    func selectNextLocale()

    /**
     Set a certain keyboard type.
     */
    func setKeyboardType(_ type: KeyboardType)
}


#if os(iOS) || os(tvOS)
extension KeyboardInputViewController: KeyboardActionTrigger {}

public extension KeyboardInputViewController {

    func adjustTextPosition(byCharacterOffset offset: Int) {
        textDocumentProxy.adjustTextPosition(byCharacterOffset: offset)
    }

    func deleteBackward() {
        textDocumentProxy.deleteBackward(range: keyboardBehavior.backspaceRange)
    }

    func insertAutocompleteSuggestion(_ suggestion: AutocompleteSuggestion) {
        textDocumentProxy.insertAutocompleteSuggestion(suggestion)
        keyboardActionHandler.handle(.release, on: .character(""))
    }

    func insertText(_ text: String) {
        textDocumentProxy.insertText(text)
    }

    func selectNextLocale() {
        keyboardContext.selectNextLocale()
    }

    func setKeyboardType(_ type: KeyboardType) {
        keyboardContext.keyboardType = type
    }
}
#endif

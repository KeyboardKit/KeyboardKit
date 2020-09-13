//
//  KeyboardContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This standard context provides non-observable properties to
 your keyboard extensions.
 
 This context type is used by default by `KeyboardKit`. If a
 keyboard extension targets iOS 13 or later, you can replace
 it with a `ObservableKeyboardContext`.
 */
public class StandardKeyboardContext: KeyboardContext {
    
    public init(
        controller: KeyboardInputViewController,
        actionHandler: KeyboardActionHandler,
        keyboardType: KeyboardType,
        defaults: UserDefaults = .standard) {
        self.defaults = defaults
        self.actionHandler = actionHandler
        self.controller = controller
        self.emojiCategory = .frequent
        self.hasDictationKey = controller.hasDictationKey
        self.hasFullAccess = controller.hasFullAccess
        self.keyboardType = keyboardType
        self.needsInputModeSwitchKey = controller.needsInputModeSwitchKey
        self.primaryLanguage = controller.primaryLanguage
        self.textDocumentProxy = controller.textDocumentProxy
        self.textInputMode = controller.textInputMode
        self.traitCollection = controller.traitCollection
    }
    
    private let defaults: UserDefaults
    
    public var actionHandler: KeyboardActionHandler
    public var controller: KeyboardInputViewController
    public var emojiCategory: EmojiCategory
    public var hasDictationKey: Bool
    public var hasFullAccess: Bool
    public var keyboardType: KeyboardType
    public var needsInputModeSwitchKey: Bool
    public var primaryLanguage: String?
    public var textDocumentProxy: UITextDocumentProxy
    public var textInputMode: UITextInputMode?
    public var traitCollection: UITraitCollection
}

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
 it with a `KeyboardKitSwiftUI` `ObservableKeyboardContext`.
 */
public class StandardKeyboardContext: KeyboardContext {
    
    public init(
        controller: KeyboardInputViewController,
        actionHandler: KeyboardActionHandler,
        keyboardType: KeyboardType,
        inputSetProvider: KeyboardInputSetProvider = StandardKeyboardInputSetProvider()) {
        self.controller = controller
        
        self.actionHandler = actionHandler
        self.emojiCategory = .frequent
        self.inputSetProvider = inputSetProvider
        self.keyboardType = keyboardType
        
        self.deviceOrientation = controller.deviceOrientation
        self.hasDictationKey = controller.hasDictationKey
        self.hasFullAccess = controller.hasFullAccess
        self.needsInputModeSwitchKey = controller.needsInputModeSwitchKey
        self.primaryLanguage = controller.primaryLanguage
        self.textDocumentProxy = controller.textDocumentProxy
        self.textInputMode = controller.textInputMode
        self.traitCollection = controller.traitCollection
    }
    
    unowned public var controller: KeyboardInputViewController
    
    public var actionHandler: KeyboardActionHandler
    public var emojiCategory: EmojiCategory
    public var inputSetProvider: KeyboardInputSetProvider
    public var keyboardType: KeyboardType
    
    public var deviceOrientation: UIInterfaceOrientation
    public var hasDictationKey: Bool
    public var hasFullAccess: Bool
    public var needsInputModeSwitchKey: Bool
    public var primaryLanguage: String?
    public var textDocumentProxy: UITextDocumentProxy
    public var textInputMode: UITextInputMode?
    public var traitCollection: UITraitCollection
}

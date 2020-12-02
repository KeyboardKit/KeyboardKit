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
        locale: Locale = .current,
        device: UIDevice = .current,
        controller: KeyboardInputViewController,
        actionHandler: KeyboardActionHandler,
        keyboardType: KeyboardType,
        inputSetProvider: KeyboardInputSetProvider = StandardKeyboardInputSetProvider(),
        keyboardLayoutProvider: KeyboardLayoutProvider = StandardKeyboardLayoutProvider()) {
        self.controller = controller
        
        self.device = device
        
        self.actionHandler = actionHandler
        self.emojiCategory = .frequent
        self.inputSetProvider = inputSetProvider
        self.keyboardLayoutProvider = keyboardLayoutProvider
        self.keyboardType = keyboardType
        self.locale = locale
        
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
    public var keyboardLayoutProvider: KeyboardLayoutProvider
    public var keyboardType: KeyboardType
    public var locale: Locale
    
    public var device: UIDevice
    public var deviceOrientation: UIInterfaceOrientation
    public var hasDictationKey: Bool
    public var hasFullAccess: Bool
    public var needsInputModeSwitchKey: Bool
    public var primaryLanguage: String?
    public var textDocumentProxy: UITextDocumentProxy
    public var textInputMode: UITextInputMode?
    public var traitCollection: UITraitCollection
}

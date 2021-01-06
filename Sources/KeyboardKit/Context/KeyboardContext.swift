//
//  KeyboardContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation
import UIKit

/**
 This protocol can be implemented by any classes that can be
 used to provide the keyboard extension with contextual info.
 */
public protocol KeyboardContext: AnyObject {
    
    
    // MARK: - DEPRECATED (Remove in KK 4)
    
    @available(*, deprecated, message: "This property will be removed in KK 4.0. Usage is strongly discouraged.")
    var controller: KeyboardInputViewController { get }
    
    
    // MARK: - Static Properties
    
    /**
     The current device.
     */
    var device: UIDevice { get }
    
    
    // MARK: - Manually set properties
    
    /**
     The action handler that will be used to handle keyboard
     actions that are triggered by the user or the system.
     */
    var actionHandler: KeyboardActionHandler { get set }

    /**
     The emoji category that should be displayed when an app
     switches over to an emoji keyboard.
     */
    var emojiCategory: EmojiCategory { get set }
    
    /**
     This behavior determines how the keyboard should behave,
     for instance to end sentences, switch keyboard etc.
     */
    var keyboardBehavior: KeyboardBehavior { get set }
    
    /**
     The current keyboard input set provider.
     */
    var keyboardInputSetProvider: KeyboardInputSetProvider { get set }
    
    /**
     The current keyboard layout provider.
     */
    var keyboardLayoutProvider: KeyboardLayoutProvider { get set }
    
    /**
     The current keyboard type. You can change this with the
     `changeKeyboardType` function, which supports delays.
     */
    var keyboardType: KeyboardType { get set }
    
    /**
     The current locale. Note that setting this may not have
     any side-effects on other properties like the input set.
     */
    var locale: Locale { get set }
    
    
    // MARK: - Synced properties
    
    /**
     The current device orientation.
     */
    var deviceOrientation: UIInterfaceOrientation { get set }
    
    /**
     Whether or not the keyboard extension has a "dictation"
     key. If not, you can provide a custom dictation button.
     */
    var hasDictationKey: Bool { get set }
    
    /**
     Whether or not the keyboard extension has "full access".
     */
    var hasFullAccess: Bool { get set }
    
    /**
     Whether or not the keyboard extension should provide an
     input mode switch key.
     */
    var needsInputModeSwitchKey: Bool { get set }
    
    /**
     The current primary language of the keyboard.
     */
    var primaryLanguage: String? { get set }
    
    /**
     The current secondary callout action provider.
     */
    var secondaryCalloutActionProvider: SecondaryCalloutActionProvider { get set }
    
    /**
     The current text document proxy.
     */
    var textDocumentProxy: UITextDocumentProxy { get set }
    
    /**
     The current text input mode.
     */
    var textInputMode: UITextInputMode? { get set }
    
    /**
     The current trait collection.
     */
    var traitCollection: UITraitCollection { get set }
}


// MARK: - Public Properties

public extension KeyboardContext {
    
    /**
     The current keyboard appearance, which is resolved from
     the `textDocumentProxy`, but has a fallback to `.light`.
     */
    var keyboardAppearance: UIKeyboardAppearance {
        textDocumentProxy.keyboardAppearance ?? .light
    }
}


// MARK: - Public Functions

public extension KeyboardContext {
    
    /**
     Sync the context with the current state of the keyboard
     input view controller.
     */
    func sync(with controller: UIInputViewController) {
        self.deviceOrientation = controller.deviceOrientation
        self.hasDictationKey = controller.hasDictationKey
        self.hasFullAccess = controller.hasFullAccess
        self.needsInputModeSwitchKey = controller.needsInputModeSwitchKey
        self.primaryLanguage = controller.primaryLanguage
        self.textDocumentProxy = controller.textDocumentProxy
        self.textInputMode = controller.textInputMode
        self.traitCollection = controller.traitCollection
    }
}

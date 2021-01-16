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
    
    @available(*, deprecated, message: "This property will be removed in KK 4.0. Usage is strongly discouraged.")
    var controller: KeyboardInputViewController { get }

    var actionHandler: KeyboardActionHandler { get set }
    var keyboardAppearanceProvider: KeyboardAppearanceProvider { get set }
    var keyboardBehavior: KeyboardBehavior { get set }
    var keyboardInputSetProvider: KeyboardInputSetProvider { get set }
    var keyboardLayoutProvider: KeyboardLayoutProvider { get set }
    
    var device: UIDevice { get }
    var deviceOrientation: UIInterfaceOrientation { get set }
    var emojiCategory: EmojiCategory { get set }
    var hasDictationKey: Bool { get set }
    var hasFullAccess: Bool { get set }
    var keyboardType: KeyboardType { get set }
    var locale: Locale { get set }
    var needsInputModeSwitchKey: Bool { get set }
    var primaryLanguage: String? { get set }
    var textDocumentProxy: UITextDocumentProxy { get set }
    var textInputMode: UITextInputMode? { get set }
    var traitCollection: UITraitCollection { get set }
}


// MARK: - Public Properties

public extension KeyboardContext {
    
    /**
     The current keyboard appearance, with `.light` fallback.
     */
    var keyboardAppearance: UIKeyboardAppearance {
        textDocumentProxy.keyboardAppearance ?? .light
    }
    
    /**
     The current keyboard layout from the active provider.
     */
    var keyboardLayout: KeyboardLayout {
        keyboardLayoutProvider.keyboardLayout(for: self)
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

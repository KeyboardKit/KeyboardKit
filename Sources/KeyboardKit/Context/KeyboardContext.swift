//
//  KeyboardContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation
import UIKit

/**
 This protocol can be implemented by any classes that can be
 used to provide the keyboard extension with contextual info.
 */
public protocol KeyboardContext: AnyObject {
    
    /**
     The current keyboard action handler that can be used to
     handle actions that are triggered by the user or system.
     It can be replaced with any `KeyboardActionHandler`.
     */
    var actionHandler: KeyboardActionHandler { get set }
    
    /**
     The current keyboard input view controller. You can use
     this to get information that is not in the context.
     */
    var controller: KeyboardInputViewController { get }
    
    /**
     The emoji category that should be displayed when an app
     switches over to an emoji keyboard.
     */
    var emojiCategory: EmojiCategory { get set }
    
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
     The current keyboard appearance.
     */
    var keyboardAppearance: UIKeyboardAppearance { get }
    
    /**
     The current keyboard type. You this type as you want.
     */
    var keyboardType: KeyboardType { get set }
    
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
     The current text document proxy.
     */
    var textDocumentProxy: UITextDocumentProxy { get set }
    
    /**
     The current text input mode.
     */
    var textInputMode: UITextInputMode? { get set }
    
    /**
     The current user interface style.
     */
    @available(iOS 12.0, *)
    var userInterfaceStyle: UIUserInterfaceStyle { get }
}


// MARK: - Public Properties

public extension KeyboardContext {
    
    /**
     The current keyboard appearance, which is resolved from
     the `textDocumentProxy`.
     */
    var keyboardAppearance: UIKeyboardAppearance {
        textDocumentProxy.keyboardAppearance ?? .light
    }
    
    /**
     The current user interface style. This is resolved from
     the `controller`s `traitCollection`.
     
     `IMPORTANT` Both this and the `colorScheme` environment
     property in SwiftUI will incorrectly be `.dark`, if the
     keyboard appearance is `.dark` in light mode. This will
     cause UI bugs in the system styles, since dark keyboard
     appearance in light mode does not look the same as dark
     mode keyboards. You can see this bug in practice if you
     run the demo app and activate the SwiftUI demo keyboard
     on a text field that requires dark keyboard appearance.
     
     Bug info (also reported to Apple in Feedback Assistant):
     https://github.com/danielsaidi/KeyboardKit/issues/107
     */
    @available(iOS 12.0, *)
    var userInterfaceStyle: UIUserInterfaceStyle {
        controller.traitCollection.userInterfaceStyle
    }
}


// MARK: - Public Functions

public extension KeyboardContext {
    
    /**
     This function changes keyboard type, using the standard
     system behavior, where it's not possible to change from
     caps locked keyboards to upper-case ones.
     
     The delay can be used to allow a double-tap action time
     to finish before changing the keyboard.
     */
    func changeKeyboardType(to type: KeyboardType, after delay: DispatchTimeInterval, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            guard self.keyboardType.canBeReplaced(with: type) else { return }
            self.keyboardType = type
            completion()
        }
    }
    
    /**
     Sync the context with the current state of the keyboard
     input view controller.
     */
    func sync(with controller: UIInputViewController) {
        self.hasDictationKey = controller.hasDictationKey
        self.hasFullAccess = controller.hasFullAccess
        self.needsInputModeSwitchKey = controller.needsInputModeSwitchKey
        self.primaryLanguage = controller.primaryLanguage
        self.textDocumentProxy = controller.textDocumentProxy
        self.textInputMode = controller.textInputMode
    }
}

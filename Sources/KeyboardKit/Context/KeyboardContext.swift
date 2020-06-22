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
     This handler can handle actions that are triggered by a
     user or the system. It can be replaced with any handler.
     */
    var actionHandler: KeyboardActionHandler { get set }
    
    /**
     Whether or not a keyboard extension has a dictation key.
     If so, the system dictation key will be disabled
     */
    var hasDictationKey: Bool { get set }
    
    /**
     Whether or not the keyboard extension has full access.
     */
    var hasFullAccess: Bool { get set }
    
    /**
     The currently selected keyboard type, which can be used
     in any way you like.
     */
    var keyboardType: KeyboardType { get set }
    
    /**
     Whether or not the keyboard extension must provide your
     current user with an input mode switch key.
     */
    var needsInputModeSwitchKey: Bool { get set }
    
    /**
     The current text document proxy.
     */
    var textDocumentProxy: UITextDocumentProxy { get set }
    
    /**
     The current text input mode.
     */
    var textInputMode: UITextInputMode? { get set }
    
    /**
     The current primary language of the keyboard.
     */
    var primaryLanguage: String? { get set }
}

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

//
//  KeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any classes that can be
 used to generate a ``KeyboardLayout`` for a certain context.
 
 KeyboardKit will create a ``StandardKeyboardLayoutProvider``
 instance when the keyboard extension is started, then apply
 it to ``KeyboardInputViewController/keyboardLayoutProvider``
 and use it by default when generating keyboard layouts.
 
 KeyboardKit Pro can be used to unlock a unique provider for
 every ``KeyboardLocale``, which means that you can create a
 fully localized ``SystemKeyboard`` for all keyboard locales
 with just a single line of code.
 
 To create a custom implementation of this protocol, you can
 implement it from scratch or inherit the standard class and
 override the parts that you want to change. When the custom
 implementation is done, you can just replace the controller
 service to make KeyboardKit use the custom service globally.
 */
public protocol KeyboardLayoutProvider: AnyObject {
    
    /**
     The layout keyboard to use for a given keyboard context.
     */
    func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout
    
    @available(*, deprecated, message: "Use input sets directly instead.")
    func register(inputSetProvider: InputSetProvider)
}



//
//  KeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by classes that can return
 keyboard layouts for any ``KeyboardContext``.
 
 Keyboard layouts can be used by keyboard-related views like
 ``SystemKeyboard`` to provide information about the keys to
 show, what size each key should have, etc.
 
 KeyboardKit will create a ``StandardKeyboardLayoutProvider``
 instance when the keyboard extension is started, then apply
 it to ``KeyboardInputViewController/state``. It's then used
 as the default provider, for instance in ``SystemKeyboard``.
 
 To change the layouts that are used for different keyboards,
 you can implement a custom provider.
 
 To create a custom implementation of this protocol, you can
 implement it from scratch or inherit the standard class and
 override the parts that you want to change. When the custom
 implementation is done, you can just replace the controller
 service to make KeyboardKit use the custom service globally.
 
 KeyboardKit Pro unlock localized providers for all locales.
 */
public protocol KeyboardLayoutProvider: AnyObject {
    
    /// Get a keyboard layout for the provided context.
    func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout
}

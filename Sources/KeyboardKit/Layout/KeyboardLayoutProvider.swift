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
 
 KeyboardKit will inject a ``StandardKeyboardLayoutProvider``
 into ``KeyboardInputViewController/services``.
 
 To change the layouts that are used for different keyboards,
 you can implement a custom provider.
 
 To create a custom implementation of this protocol, you can
 either implement the protocol from scratch, or subclass the
 standard class and override what you want to change. Inject
 it into ``KeyboardInputViewController/services`` to make it
 be used as the global default.
 
 KeyboardKit Pro unlock localized providers for all locales.
 */
public protocol KeyboardLayoutProvider: AnyObject {
    
    /// Get a keyboard layout for the provided context.
    func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout
}

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
 
 You can create a custom implementation of this protocol, by
 inheriting and customizing the standard class or creating a
 new implementation from scratch. When you're implementation
 is ready, just replace the controller service with your own
 implementation to make the library use it instead.
 */
public protocol KeyboardLayoutProvider: AnyObject, InputSetProviderBased {
    
    /**
     The layout keyboard to use for a given keyboard context.
     */
    func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout
}

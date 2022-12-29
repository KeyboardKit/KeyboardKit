//
//  KeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any classes that can be
 used to generate a ``KeyboardLayout`` for a certain context.
 
 KeyboardKit will create a ``StandardKeyboardLayoutProvider``
 when the keyboard extension is started and then apply it to
 ``KeyboardInputViewController/keyboardLayoutProvider`` then
 use this instance by default to generate keyboard layouts.
 
 KeyboardKit comes with a ``StandardKeyboardLayoutProvider``,
 which can be initialized with an ``InputSetProvider``, then
 uses separate layout providers for iPhone and iPad.
 
 KeyboardKit Pro can be used to unlock an input set provider
 for each ``KeyboardLocale``. This means that you can create
 a completely localized ``SystemKeyboard`` for all available
 locales with just a single line of code.
 
 If you don't have a KeyboardKit Pro license, you can create
 a custom layout provider.
 
 You can create a custom implementation of this protocol, by
 either inheriting and customizing the standard class (which
 gives you a lot of functionality for free) or by creating a
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

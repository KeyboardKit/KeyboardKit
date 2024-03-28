//
//  KeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This protocol can be implemented by any classes that can
/// provide dynamic keyboard layouts.
///
/// KeyboardKit will automatically setup a standard protocol
/// implementation in ``KeyboardInputViewController/services``
/// when the keyboard is launched. You can change or replace
/// it at any time to customize the keyboard layout.
///
/// To create a custom implementation, either implement this
/// protocol from scratch, or inherit the standard class and
/// override what you want to change. You can then inject it
/// into ``KeyboardInputViewController/services`` to make it
/// the global default.
///
/// KeyboardKit Pro can be used to unlock localized provider
/// implementations for each ``KeyboardLocale``.
public protocol KeyboardLayoutProvider: AnyObject {
    
    /// Get a keyboard layout for the provided context.
    func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout
}

//
//  KeyboardLayoutService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This protocol can be implemented by any classes that can
/// generate keyboard layouts in various ways.
///
/// KeyboardKit will automatically setup a standard protocol
/// implementation in ``KeyboardInputViewController/services``
/// when the keyboard is launched. You can change or replace
/// it at any time to customize the keyboard layout.
///
/// KeyboardKit Pro can be used to unlock localized services
/// for each ``KeyboardLocale``.
///
/// See <doc:Layout-Article> for more information.
public protocol KeyboardLayoutService: AnyObject {

    /// Get a keyboard layout for the provided context.
    func keyboardLayout(
        for context: KeyboardContext
    ) -> KeyboardLayout
}

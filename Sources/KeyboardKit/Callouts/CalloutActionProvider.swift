//
//  CalloutActionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This protocol can be implemented by any classes that can
/// provide secondary callout actions for keyboard actions.
///
/// KeyboardKit will automatically setup a standard protocol
/// implementation in ``KeyboardInputViewController/services``
/// when the keyboard is launched. You can change or replace
/// it at any time to customize the keyboard callout actions.
///
/// To create a custom implementation, either implement this
/// protocol from scratch, or inherit the standard class and
/// override what you want to change. You can then inject it
/// into ``KeyboardInputViewController/services`` to make it
/// the global default.
///
/// KeyboardKit Pro can be used to unlock localized provider
/// implementations for each ``KeyboardLocale``.
public protocol CalloutActionProvider: AnyObject {
    
    /// Get secondary callout actions for a keyboard action.
    func calloutActions(
        for action: KeyboardAction
    ) -> [KeyboardAction]
}

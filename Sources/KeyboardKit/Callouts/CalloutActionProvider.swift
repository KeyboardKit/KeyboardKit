//
//  CalloutActionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This protocol can be implemented by any classes that can
/// provide secondary keyboard callout actions.
///
/// KeyboardKit will automatically setup a standard protocol
/// implementation in ``KeyboardInputViewController/services``
/// when the keyboard is launched. You can change or replace
/// it at any time to customize the keyboard callout actions.
///
/// KeyboardKit Pro can be used to unlock localized provider
/// implementations for each ``KeyboardLocale``.
///
/// See <doc:Callouts-Article> for more information.
public protocol CalloutActionProvider: AnyObject {
    
    /// Get callout actions for the provided keyboard action.
    func calloutActions(
        for action: KeyboardAction
    ) -> [KeyboardAction]
}

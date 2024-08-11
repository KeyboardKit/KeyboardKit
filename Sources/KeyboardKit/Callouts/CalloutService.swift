//
//  CalloutService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This protocol can be implemented by any type that can be
/// used perform callout-related actions.
///
/// KeyboardKit will automatically setup a standard protocol
/// implementation in ``KeyboardInputViewController/services``
/// when the keyboard is launched. You can change or replace
/// it at any time to customize the callout behavior.
///
/// KeyboardKit Pro can be used to unlock localized services
/// for each ``KeyboardLocale``.
///
/// See <doc:Callouts-Article> for more information.
public protocol CalloutService: AnyObject {

    /// Get callout actions for the provided keyboard action.
    func calloutActions(
        for action: KeyboardAction
    ) -> [KeyboardAction]
}

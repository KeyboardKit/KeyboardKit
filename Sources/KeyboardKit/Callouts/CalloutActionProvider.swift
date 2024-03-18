//
//  CalloutActionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by classes that can return
 secondary callout actions for any ``KeyboardAction``.
 
 KeyboardKit will register a ``StandardCalloutActionProvider``
 with ``KeyboardInputViewController/services``. It will then
 be used as the default action provider.
 
 To change the callout actions that are shown when different
 keys are long pressed, you can implement a custom provider.
 
 To create a custom implementation of this protocol, you can
 either implement the protocol from scratch, or subclass the
 standard class and override what you want to change. Inject
 it into ``KeyboardInputViewController/services`` to make it
 be used as the global default.
 
 KeyboardKit Pro unlock localized providers for all locales.
 */
public protocol CalloutActionProvider: AnyObject {
    
    /// Get secondary callout actions for a certain action.
    func calloutActions(for action: KeyboardAction) -> [KeyboardAction]
}

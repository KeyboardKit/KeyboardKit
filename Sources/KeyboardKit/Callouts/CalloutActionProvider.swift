//
//  CalloutActionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by classes that can return
 secondary callout actions for keyboard actions.
 
 Callout actions are shown in a callout above the key when a
 user long presses a key for an action that has such actions.
 
 KeyboardKit will create a ``StandardCalloutActionProvider``
 instance when the keyboard extension is started, then apply
 it to ``KeyboardInputViewController/calloutActionProvider``.
 This instance is then used by default to get the actions to
 display for a certain action.
 
 To change the callout actions that are shown when different
 keys are long pressed, you can implement a custom provider.
 
 To create a custom implementation of this protocol, you can
 implement it from scratch or inherit the standard class and
 override the parts that you want to change. When the custom
 implementation is done, you can just replace the controller
 service to make KeyboardKit use the custom service globally.
 
 KeyboardKit Pro unlock localized providers for all locales.
 */
public protocol CalloutActionProvider: AnyObject {
    
    /**
     Get callout actions for the provided `action`.
     
     These actions are presented in a callout when a user is
     long pressing this action.
     */
    func calloutActions(for action: KeyboardAction) -> [KeyboardAction]
}

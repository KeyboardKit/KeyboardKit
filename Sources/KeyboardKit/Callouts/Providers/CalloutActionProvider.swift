//
//  CalloutActionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any classes that can be
 used to get secondary callout actions for a keyboard action.
 
 KeyboardKit automatically creates an implementation of this
 protocol and binds it to ``KeyboardInputViewController``.
 */
public protocol CalloutActionProvider {
    
    /**
     Get callout actions for the provided `action`.
     
     These actions are presented in a callout when a user is
     long pressing this action.
     */
    func calloutActions(for action: KeyboardAction) -> [KeyboardAction]
}

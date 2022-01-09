//
//  SecondaryCalloutActionProvider.swift
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
public protocol SecondaryCalloutActionProvider {
    
    /**
     Get secondary callout actions for the provided `action`.
     
     These are the secondary actions that are presented in a
     callout when the user long presses the key of an action
     that has alternative actions.
     */
    func secondaryCalloutActions(for action: KeyboardAction) -> [KeyboardAction]
}

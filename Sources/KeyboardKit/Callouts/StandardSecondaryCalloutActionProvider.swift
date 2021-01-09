//
//  StandardSecondaryCalloutActionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This provider is used by default, and provides the standard
 secondary callout actions for the current locale, if any.
 
 Note that this implementation only accepts and returns char
 actions, since that is what the built-in callout supports.
 
 You can inherit and customize this class to create your own
 provider that builds on this foundation.
 */
open class StandardSecondaryCalloutActionProvider: SecondaryCalloutActionProvider {
    
    public init() {}
    
    open func secondaryCalloutActions(for action: KeyboardAction, in context: KeyboardContext) -> [KeyboardAction] {
        action.standardSecondaryCalloutActions(for: context.locale)
    }
}

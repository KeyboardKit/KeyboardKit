//
//  StandardSecondaryCalloutActionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This provider provides secondary callouts with the standard
 secondary callout actions for the provided action.
 */
open class StandardSecondaryCalloutActionProvider: SecondaryCalloutActionProvider {
    
    public init() {}
    
    open func secondaryCalloutActions(for action: KeyboardAction, in context: KeyboardContext) -> [KeyboardAction] {
        action.standardSecondaryCalloutActions(for: context.locale)
    }
}

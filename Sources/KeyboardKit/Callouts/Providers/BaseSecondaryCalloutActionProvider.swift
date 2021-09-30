//
//  BaseSecondaryCalloutActionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This base class simplifies creating secondary callout input
 providers, by providing a set of utility functions.
 
 You can inherit this class and override any open properties
 and functions to customize the standard behavior.
 
 It's easiest to just override `secondaryCalloutActionString`
 and return a string with all callout characters. The string
 is then split and returned by `secondaryCalloutActions`.
 
 `EnglishSecondaryCalloutActionProvider` uses this technique
 to specify secondary callout actions for U.S. English. Have
 a look at that class for inspiration.
 */
open class BaseSecondaryCalloutActionProvider: SecondaryCalloutActionProvider {
    
    public init() {}
    
    /**
     Get secondary callout actions for the provided `action`.
     
     These are the secondary actions that are presented in a
     callout when the user long presses the key of an action
     that has alternative actions.
     */
    open func secondaryCalloutActions(for action: KeyboardAction) -> [KeyboardAction] {
        switch action {
        case .character(let char): return secondaryCalloutActions(for: char)
        default: return []
        }
    }
    
    /**
     Get secondary callout actions for the provided `char`.
     
     This will split the `secondaryCalloutActionString` into
     secondary `.character` actions.
     */
    open func secondaryCalloutActions(for char: String) -> [KeyboardAction] {
        let charValue = char.lowercased()
        let result = secondaryCalloutActionString(for: charValue)
        let string = char.isUppercased ? result.uppercased() : result
        return string.map { .character(String($0)) }
    }
    
    /**
     Get secondary callout actions as a string for the `char`.
     
     This will be split by the `secondaryCalloutActions`, to
     create secondary `.character` actions.
     */
    open func secondaryCalloutActionString(for char: String) -> String {
        ""
    }
}

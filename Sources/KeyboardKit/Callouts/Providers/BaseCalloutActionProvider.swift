//
//  BaseSecondaryCalloutActionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This class simplifies creating callout action providers, by
 providing a set of utility functions.
 
 You can inherit this class and override any open properties
 and functions to customize the standard behavior.
 
 It's easiest to just override ``calloutActionString(for:)``
 and return a string with all callout characters. The string
 is then split and mapped into keyboard actions and returned
 by the other functions.
 
 ``EnglishCalloutActionProvider`` uses this logic to specify
 which actions to use for U.S. English.
 */
open class BaseCalloutActionProvider: CalloutActionProvider {
    
    public init() throws {}
    
    /**
     Get callout actions for the provided `action`.
     
     These actions are presented in a callout when a user is
     long pressing this action.
     */
    open func calloutActions(for action: KeyboardAction) -> [KeyboardAction] {
        switch action {
        case .character(let char): return calloutActions(for: char)
        default: return []
        }
    }
    
    /**
     Get callout actions for the provided `char`.
     
     These actions are presented in a callout when a user is
     long pressing this character.
     */
    open func calloutActions(for char: String) -> [KeyboardAction] {
        let charValue = char.lowercased()
        let result = calloutActionString(for: charValue)
        let string = char.isUppercased ? result.uppercased() : result
        return string.map { .character(String($0)) }
    }
    
    /**
     Get callout actions as a string for the provided `char`.
     
     Override this function if you want the `calloutActions`
     functions to split this string into character actions.
     */
    open func calloutActionString(for char: String) -> String { "" }
}

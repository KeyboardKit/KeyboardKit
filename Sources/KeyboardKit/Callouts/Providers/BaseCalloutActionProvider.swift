//
//  BaseCalloutActionProvider.swift
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
 and functions to customize the callout actions. The easiest
 way is to override ``calloutActionString(for:)`` and return
 a string with all callout characters. This string will then
 be split by ``calloutActions(for:)`` and mapped to keyboard
 actions, which are then returned up the call stack.
 
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

     You can override this function if you want to customize
     the string that the ``calloutActions(for:)`` by default
     will split into a list of character ``KeyboardAction``s.
     */
    open func calloutActionString(for char: String) -> String { "" }
}

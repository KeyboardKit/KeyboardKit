//
//  BaseCalloutActionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-01.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This base class provides functionality to simplify creating
 a callout action provider.
 
 You can inherit this class and override any open properties
 and functions to customize the callout actions. The easiest
 way is to override `calloutActionString(for:)` and return a
 string that is then split and mapped to keyboard actions by
 `calloutActions(for:)`.
 
 ``EnglishCalloutActionProvider`` uses this logic to specify
 which actions to use for basic English.
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
     the string that by default will be split into a list of
     ``KeyboardAction``s by `calloutActions(for:)`.

     Note that you must override `calloutActions(for:)` when
     these actions must support multuple multiple characters,
     e.g. for `kr` currencies, or when you want to use other
     action types than just characters.
     */
    open func calloutActionString(for char: String) -> String { "" }
}

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
    
    open func secondaryCalloutActions(for action: KeyboardAction) -> [KeyboardAction] {
        switch action {
        case .character(let char): return secondaryCalloutActions(for: char)
        default: return []
        }
    }
    
    open func secondaryCalloutActions(for char: String) -> [KeyboardAction] {
        let charValue = char.lowercased()
        let result = secondaryCalloutActionString(for: charValue)
        let string = char.isUppercased ? result.uppercased() : result
        return string.map { .character(String($0)) }
    }
    
    open func secondaryCalloutActionString(for char: String) -> String {
        ""
    }
}

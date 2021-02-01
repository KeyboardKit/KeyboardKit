//
//  BaseSecondaryCalloutActionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This base class can be used to build locale-specific action
 providers.
 
 It's easiest to just override `secondaryCalloutActionString`
 and let `secondaryCalloutActions` handle casing & splitting.
 It will then provide the string function with a lower-cased
 string and handle returning a correctly cased result.
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

private extension String {
    
    var isUppercased: Bool { self == uppercased() }
}

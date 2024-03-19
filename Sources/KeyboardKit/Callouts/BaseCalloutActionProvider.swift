//
//  BaseCalloutActionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-09-26.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This is a base class for custom callout action providers.

 You can inherit this class to get access to convenient base
 functionality, then override any parts you want to change.
 
 This class only returns alphabetic, English callout actions.
 For localized, as well as symbolic, numeric and emoji-based
 callout actions, you must either implement this yourself or
 upgrade to KeyboardKit Pro.
 */
open class BaseCalloutActionProvider: CalloutActionProvider {
    
    /// Create a base callout action provider.
    public init() {}
    
    
    /// Get callout actions for the provided `action`.
    ///
    /// These actions are presented in a callout when a user
    /// is long pressing the action.
    open func calloutActions(
        for action: KeyboardAction
    ) -> [KeyboardAction] {
        switch action {
        case .character(let char): return calloutActions(for: char)
        default: return []
        }
    }
    
    /// Get callout actions for the provided `char`.
    ///
    /// These actions are presented in a callout when a user
    /// is long pressing this character.
    open func calloutActions(
        for char: String
    ) -> [KeyboardAction] {
        let charValue = char.lowercased()
        let result = calloutActionString(for: charValue)
        let string = char.isUppercasedWithLowercaseVariant ? result.uppercased() : result
        return string.map { .character(String($0)) }
    }

    /// Get callout actions as a string for a certain `char`.
    ///
    /// The string will be split and mapped to actions, then
    /// used by `calloutActions(for:)`.
    open func calloutActionString(
        for char: String
    ) -> String {
        switch char {
        case "a": "aàáâäæãåā"
        case "c": "cçćč"
        case "e": "eèéêëēėę"
        case "i": "iîïíīįì"
        case "l": "lł"
        case "n": "nñń"
        case "o": "oôöòóœøōõ"
        case "s": "sßśš"
        case "u": "uûüùúū"
        case "y": "yÿ"
        case "z": "zžźż"
            
        case "0": "0°"
            
        case "-": "-–—•"
        case "/": "/\\"
        case "$": "$₽¥€¢£₩"
        case "&": "&§"
        case "”": "\"„“”«»"
        case ".": ".…"
        case "?": "?¿"
        case "!": "!¡"
        case "’": "'’‘`"
            
        case "%": "%‰"
        case "=": "=≠≈"
            
        default: ""
        }
    }
}

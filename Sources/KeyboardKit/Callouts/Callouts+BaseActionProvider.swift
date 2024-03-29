//
//  Callouts+BaseActionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-09-26.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

extension Callouts {
    
    /// This class provides a base set of callout actions.
    ///
    /// This class only provides alphabetic, English callout
    /// actions. For localized, as well as symbolic, numeric
    /// and emoji-based callout actions, you must either use
    /// KeyboardKit Pro or create your own providers.
    ///
    /// You can inherit this class to get base functionality,
    /// then override any open parts that you want to change.
    ///
    /// See <doc:Callouts-Article> for more information.
    open class BaseActionProvider: CalloutActionProvider {
        
        /// Create a base callout action provider.
        public init() {}
        
        
        /// Get callout actions for the provided action.
        open func calloutActions(
            for action: KeyboardAction
        ) -> [KeyboardAction] {
            switch action {
            case .character(let char): return calloutActions(for: char)
            default: return []
            }
        }
        
        /// Get callout actions for the provided character.
        open func calloutActions(
            for char: String
        ) -> [KeyboardAction] {
            let charValue = char.lowercased()
            let result = calloutActionString(for: charValue)
            let string = char.isUppercasedWithLowercaseVariant ? result.uppercased() : result
            return string.map { .character(String($0)) }
        }
        
        /// Get callout actions as a string for a character.
        ///
        /// The string will be split, then mapped to actions
        /// that are used by `calloutActions(for:)`.
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
}

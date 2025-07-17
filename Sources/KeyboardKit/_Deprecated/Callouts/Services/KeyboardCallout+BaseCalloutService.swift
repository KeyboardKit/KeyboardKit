//
//  Callouts+BaseCalloutService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-09-26.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

extension KeyboardCallout {

    /// > Warning: The callout service concept is deprecated
    /// and will be removed in KeyboardKit 10.
    ///
    /// This is a base class for any kind of callout service.
    open class BaseCalloutService: KeyboardCalloutService {

        /// Create a base callout service.
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
            let result = calloutActionString(for: char.lowercased())
            let string = char.isUppercasedWithLowercaseVariant ? result.uppercased() : result
            return string.filter { $0 != " " }.map { .character(String($0)) }
        }
        
        /// Get callout actions as a string for a character.
        ///
        /// The string will be split, then mapped to actions
        /// that are used by `calloutActions(for:)`.
        open func calloutActionString(
            for char: String
        ) -> String {
            switch char {
            case "a": "aàáâäǎæãåāăą"
            case "c": "cçćčċ"
            case "d": "dďð"
            case "e": "eèéêëēėę"
            case "g": "gğġ"
            case "h": "hħ"
            case "i": "iîìíïǐĩī"
            case "k": "kķ"
            case "l": "lłļľ"
            case "n": "nñńņň"
            case "o": "oòóôöǒœøõōő"
            case "r": "rř"
            case "s": "sßśšŝṣș"
            case "t": "tțťþ"
            case "u": "uǔûùúüũūu"
            case "w": "wŵ"
            case "y": "yýŷÿ"
            case "z": "zźžż"
                
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

        /// The base service doesn't trigger any feedback.
        open func triggerFeedbackForSelectionChange() {}
    }
}

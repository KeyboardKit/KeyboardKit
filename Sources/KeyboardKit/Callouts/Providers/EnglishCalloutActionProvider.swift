//
//  EnglishCalloutActionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-01.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This class provides U.S. English callout actions.
 
 You can use the class as a template when you want to create
 your own callout action provider.
 
 KeyboardKit Pro adds a provider for each ``KeyboardLocale``
 Check out the demo app to see them in action.
 */
open class EnglishCalloutActionProvider: BaseCalloutActionProvider, LocalizedService {

    /**
     The locale key that the provider is bound to.
     */
    public let localeKey = KeyboardLocale.english.id
    
    /**
     Get callout actions as a string for the provided `char`.
     */
    open override func calloutActionString(for char: String) -> String {
        switch char {
        case "0": return "0°"

        case "a": return "aàáâäæãåā"
        case "c": return "cçćč"
        case "e": return "eèéêëēėę"
        case "i": return "iîïíīįì"
        case "l": return "lł"
        case "n": return "nñń"
        case "o": return "oôöòóœøōõ"
        case "s": return "sßśš"
        case "u": return "uûüùúū"
        case "y": return "yÿ"
        case "z": return "zžźż"
            
        case "-": return "-–—•"
        case "/": return "/\\"
        case "$": return "$€£¥₩₽¢"
        case "&": return "&§"
        case "”", "“": return "\"”“„»«"
        case ".": return ".…"
        case "?": return "?¿"
        case "!": return "!¡"
        case "'", "’": return "'’‘`"
            
        case "%": return "%‰"
        case "=": return "=≠≈"
            
        default: return ""
        }
    }
}

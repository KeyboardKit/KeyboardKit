//
//  EnglishCalloutActionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This class provides U.S. English callout actions.
 */
open class EnglishCalloutActionProvider: BaseCalloutActionProvider, LocalizedService {
    
    public let localeKey: String = KeyboardLocale.english.id
    
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

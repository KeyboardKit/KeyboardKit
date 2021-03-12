//
//  EnglishSecondaryCalloutActionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This class provides English secondary callout actions.
 */
open class EnglishSecondaryCalloutActionProvider: BaseSecondaryCalloutActionProvider, LocalizedService {
    
    public let localeKey: String = LocaleKey.english.key
    
    open override func secondaryCalloutActionString(for char: String) -> String {
        switch char {
        case "-": return "-–—•"
        case "/": return "/\\"
        case "&": return "&§"
        case "”", "“": return "\"”“„»«"
        case ".": return ".…"
        case "?": return "?¿"
        case "!": return "!¡"
        case "'", "’": return "'’‘`"
            
        case "%": return "%‰"
        case "=": return "=≠≈"
        
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
            
        default: return ""
        }
    }
}

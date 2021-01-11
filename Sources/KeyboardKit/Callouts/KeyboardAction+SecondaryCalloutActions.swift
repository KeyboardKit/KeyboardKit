//
//  KeyboardAction+SecondaryCalloutActions.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardAction {
    
    /**
     This returns the standard secondary callout actions for
     a keyboard action.
     
     Missing locales should be added when needed. Until then,
     all missing locales receive the English result.
     */
    func standardSecondaryCalloutActions(for locale: Locale) -> [KeyboardAction] {
        switch self {
        case .character(let char): return char.standardActions(for: locale)
        default: return []
        }
    }
}

private extension String {
    
    var isUppercased: Bool { self == uppercased() }
    
    var swedish: String { "sv" }
    
    func standardActions(for locale: Locale) -> [KeyboardAction] {
        let result = lowercased().string(for: locale)
        let string = isUppercased ? result.uppercased() : result
        return string.splitActions
    }
    
    func string(for locale: Locale) -> String {
        switch self {
        case "-": return "-–—•"
        case "/": return "/\\"
        case "&": return "&§"
        case "”": return "\"”“„»«"
        case ".": return ".…"
        case "?": return "?¿"
        case "!": return "!¡"
        case "'", "’": return "'’‘`"
            
        case "%": return "%‰"
        case "=": return "=≠≈"
            
        case "kr": return "€$£¥₩₽".appending("kr")
        
        case "a": return stringForA(and: locale)
        case "c": return "cç"
        case "e": return stringForE(and: locale)
        case "i": return stringForI(and: locale)
        case "l": return stringForL(and: locale)
        case "n": return "nñ"
        case "o": return stringForO(and: locale)
        case "s": return "sßśš"
        case "u": return stringForU(and: locale)
        case "y": return stringForY(and: locale)
        case "z": return stringForZ(and: locale)
        case "ä": return "äæ"
        case "ö": return "öø"
        
        default: return ""
        }
    }
    
    func stringForA(and locale: Locale) -> String {
        switch locale.languageCode {
        case swedish: return "aáàâãā"
        default: return "aàáâäæãåā"
        }
    }
    
    func stringForC(and locale: Locale) -> String {
        switch locale.languageCode {
        case swedish: return "cç"
        default: return "cçćč"
        }
    }
    
    func stringForE(and locale: Locale) -> String {
        switch locale.languageCode {
        case swedish: return "eéëèêẽēę"
        default: return "eèéêëēėę"
        }
    }
    
    func stringForI(and locale: Locale) -> String {
        switch locale.languageCode {
        case swedish: return "iīîíïìĩ"
        default: return "iîïíīįì"
        }
    }
    
    func stringForL(and locale: Locale) -> String {
        switch locale.languageCode {
        case swedish: return ""
        default: return "lł"
        }
    }
    
    func stringForN(and locale: Locale) -> String {
        switch locale.languageCode {
        case swedish: return "nñ"
        default: return "nñń"
        }
    }
    
    func stringForO(and locale: Locale) -> String {
        switch locale.languageCode {
        case swedish: return "oœóòôõ"
        default: return "oôöòóœøōõ"
        }
    }
    
    func stringForU(and locale: Locale) -> String {
        switch locale.languageCode {
        case swedish: return "uûúüùũū"
        default: return "uûüùúū"
        }
    }
    
    func stringForY(and locale: Locale) -> String {
        switch locale.languageCode {
        case swedish: return ""
        default: return "yÿ"
        }
    }
    
    func stringForZ(and locale: Locale) -> String {
        switch locale.languageCode {
        case swedish: return ""
        default: return "zžźż"
        }
    }
    
    
    var splitActions: [KeyboardAction] {
        map { .character(String($0)) }
    }
}

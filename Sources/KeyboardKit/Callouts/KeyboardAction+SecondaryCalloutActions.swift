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
    
    var swedish: String { "sv" }
    
    func standardActions(for locale: Locale) -> [KeyboardAction] {
        switch self {
        case "-": return "-–—•".splitActions
        case "/": return "/\\".splitActions
        case "&": return "&§".splitActions
        case "”": return "\"”“„»«".splitActions
        case ".": return ".…".splitActions
        case "?": return "?¿".splitActions
        case "!": return "!¡".splitActions
        case "'", "’": return "'’‘`".splitActions
            
        case "%": return "%‰".splitActions
        case "=": return "=≠≈".splitActions
            
        case "kr": return "€$£¥₩₽".splitActions.appending(.character("kr"))
        
        case "a": return standardActionsForA(and: locale)
        case "c": return "cç".splitActions
        case "e": return standardActionsForE(and: locale)
        case "i": return standardActionsForI(and: locale)
        case "l": return standardActionsForL(and: locale)
        case "n": return "nñ".splitActions
        case "o": return standardActionsForO(and: locale)
        case "s": return "sßśš".splitActions
        case "u": return standardActionsForU(and: locale)
        case "y": return standardActionsForY(and: locale)
        case "z": return standardActionsForZ(and: locale)
        case "ä": return "äæ".splitActions
        case "ö": return "öø".splitActions
        
        default: return []
        }
    }
    
    func standardActionsForA(and locale: Locale) -> [KeyboardAction] {
        switch locale.languageCode {
        case swedish: return "aáàâãā".splitActions
        default: return "aàáâäæãåā".splitActions
        }
    }
    
    func standardActionsForC(and locale: Locale) -> [KeyboardAction] {
        switch locale.languageCode {
        case swedish: return "cç".splitActions
        default: return "cçćč".splitActions
        }
    }
    
    func standardActionsForE(and locale: Locale) -> [KeyboardAction] {
        switch locale.languageCode {
        case swedish: return "eéëèêẽēę".splitActions
        default: return "eèéêëēėę".splitActions
        }
    }
    
    func standardActionsForI(and locale: Locale) -> [KeyboardAction] {
        switch locale.languageCode {
        case swedish: return "iīîíïìĩ".splitActions
        default: return "iîïíīįì".splitActions
        }
    }
    
    func standardActionsForL(and locale: Locale) -> [KeyboardAction] {
        switch locale.languageCode {
        case swedish: return []
        default: return "lł".splitActions
        }
    }
    
    func standardActionsForN(and locale: Locale) -> [KeyboardAction] {
        switch locale.languageCode {
        case swedish: return "nñ".splitActions
        default: return "nñń".splitActions
        }
    }
    
    func standardActionsForO(and locale: Locale) -> [KeyboardAction] {
        switch locale.languageCode {
        case swedish: return "oœóòôõ".splitActions
        default: return "oôöòóœøōõ".splitActions
        }
    }
    
    func standardActionsForU(and locale: Locale) -> [KeyboardAction] {
        switch locale.languageCode {
        case swedish: return "uûúüùũū".splitActions
        default: return "uûüùúū".splitActions
        }
    }
    
    func standardActionsForY(and locale: Locale) -> [KeyboardAction] {
        switch locale.languageCode {
        case swedish: return []
        default: return "yÿ".splitActions
        }
    }
    
    func standardActionsForZ(and locale: Locale) -> [KeyboardAction] {
        switch locale.languageCode {
        case swedish: return []
        default: return "zžźż".splitActions
        }
    }
    
    
    var splitActions: [KeyboardAction] {
        map { .character(String($0)) }
    }
}

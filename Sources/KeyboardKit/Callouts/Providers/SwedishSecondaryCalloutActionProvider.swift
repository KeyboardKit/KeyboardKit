//
//  SwedishSecondaryCalloutActionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This class provides Swedish secondary callout actions.
 */
open class SwedishSecondaryCalloutActionProvider: BaseSecondaryCalloutActionProvider {
    
    open override func secondaryCalloutActions(for action: KeyboardAction) -> [KeyboardAction] {
        var actions = super.secondaryCalloutActions(for: action)
        guard action.isKr else { return actions }
        actions.insert(.character("kr"), at: 0)
        return actions
    }
    
    open override func secondaryCalloutActionString(for char: String) -> String {
        switch char {
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
            
        case "kr": return "€$£¥₩₽"
        
        case "a": return "aáàâãā"
        case "c": return "cç"
        case "e": return "eéëèêẽēę"
        case "i": return "iīîíïìĩ"
        case "n": return "nñ"
        case "o": return "oœóòôõ"
        case "s": return "sßśš"
        case "u": return "uûúüùũū"
        case "ä": return "äæ"
        case "ö": return "öø"
        
        default: return ""
        }
    }
}

private extension KeyboardAction {
    
    var isKr: Bool {
        switch self {
        case .character(let char): return char == "kr"
        default: return false
        }
    }
}

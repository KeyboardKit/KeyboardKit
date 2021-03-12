//
//  SwedishSecondaryCalloutActionProvider.swift
//  KeyboardKitPro
//
//  Created by Daniel Saidi on 2021-02-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit

/**
 This class provides Swedish secondary callout actions.
 */
public class SwedishSecondaryCalloutActionProvider: BaseSecondaryCalloutActionProvider, LocalizedService {
    
    public let localeKey: String = LocaleKey.swedish.key
    
    public override func secondaryCalloutActions(for action: KeyboardAction) -> [KeyboardAction] {
        var actions = super.secondaryCalloutActions(for: action)
        guard action.isKr else { return actions }
        actions.insert(.character("kr"), at: 0)
        return actions
    }
    
    public override func secondaryCalloutActionString(for char: String) -> String {
        switch char {
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

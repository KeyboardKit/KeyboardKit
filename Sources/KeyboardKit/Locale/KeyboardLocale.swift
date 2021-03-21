//
//  KeyboardLocale.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum contains KeyboardKit-supported locales. They have
 more information than their raw locales and can also have a
 set of corresponding services attatched to them.
 */
public enum KeyboardLocale: String, CaseIterable, Identifiable {
    
    case english = "en"
    
    case danish = "da"
    case dutch = "nl"
    case finnish = "fi"
    case german = "de"
    case italian = "it"
    case norwegian = "nb"
    case swedish = "sv"
}

public extension KeyboardLocale {
    
    /**
     The unique identifier of the locale.
     */
    var id: String { rawValue }
    
    /**
     The raw locale that is connected to the keyboard locale.
     */
    var locale: Locale { Locale(identifier: localeIdentifier) }
    
    /**
     The identifier that is used to identify the raw locale.
     */
    var localeIdentifier: String { id }
    
    /**
     The unique identifier of the locale.
     */
    var localizedName: String { locale.localizedString(forIdentifier: id) ?? "" }
    
    /**
     The corresponding flag emoji for the locale.
     */
    var flag: String {
        switch self {
        case .danish: return "🇩🇰"
        case .dutch: return "🇳🇱"
        case .english: return "🇺🇸"
        case .finnish: return "🇫🇮"
        case .german: return "🇩🇪"
        case .italian: return "🇮🇹"
        case .norwegian: return "🇳🇴"
        case .swedish: return "🇸🇪"
        }
    }
}

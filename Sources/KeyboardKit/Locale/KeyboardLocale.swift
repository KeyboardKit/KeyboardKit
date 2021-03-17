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
    case german = "de"
    case italian = "it"
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
    var locale: Locale { Locale(identifier: id) }
    
    /**
     The corresponding flag emoji for the locale.
     */
    var flag: String {
        switch self {
        case .english: return "🇺🇸"
        case .german: return "🇩🇪"
        case .italian: return "🇮🇹"
        case .swedish: return "🇸🇪"
        }
    }
}

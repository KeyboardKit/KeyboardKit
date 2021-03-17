//
//  LocaleKey.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum contains locales that are supported by KeyoardKit.
 */
public enum LocaleKey: String, CaseIterable {
    
    case english = "en"
    case german = "de"
    case italian = "it"
    case swedish = "sv"
}

public extension LocaleKey {
    
    /**
     */
    var key: String { rawValue }
    
    /**
     The raw locale that is connected to the keyboard locale.
     */
    var locale: Locale { Locale(identifier: key) }
    
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

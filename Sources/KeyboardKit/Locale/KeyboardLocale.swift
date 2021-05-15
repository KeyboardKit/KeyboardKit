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
    
    case danish = "da"
    case dutch = "nl"
    case english = "en"
    case english_gb = "en-GB"
    case english_us = "en-US"
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
     The localized name of the locale.
     */
    var localizedName: String {
        locale.localizedString(forIdentifier: id) ?? ""
    }
    
    /**
     The corresponding flag emoji for the locale.
     */
    var flag: String {
        switch self {
        case .danish: return "🇩🇰"
        case .dutch: return "🇳🇱"
        case .english: return "🇺🇸"
        case .english_gb: return "🇬🇧"
        case .english_us: return "🇺🇸"
        case .finnish: return "🇫🇮"
        case .german: return "🇩🇪"
        case .italian: return "🇮🇹"
        case .norwegian: return "🇳🇴"
        case .swedish: return "🇸🇪"
        }
    }
    
    /**
     Whether or not the locale is a left-to-right one.
     */
    var isLeftToRight: Bool {
        switch self {
        default: return true
        }
    }
    
    /**
     Whether or not the locale is a right-to-left one.
     */
    var isRightToLeft: Bool { !isLeftToRight }
}

public extension Collection where Element == KeyboardLocale {
    
    /**
     Sort the collection by the localized name of every item.
     */
    func sorted() -> [Element] {
        sorted { $0.localizedName.lowercased() < $1.localizedName.lowercased() }
    }
    
    /**
     Sort the collection by the localized name of every item,
     then insert a certain locale firstmost.
     */
    func sorted(insertFirst locale: Element) -> [Element] {
        var res = sorted().filter { $0 != locale }
        res.insert(locale, at: 0)
        return res
    }
}

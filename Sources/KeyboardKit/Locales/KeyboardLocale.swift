//
//  KeyboardLocale.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-01.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum contains KeyboardKit-supported locales.
 
 Keyboard locales have more information than raw locales and
 can also have a set of related services. For instance, when
 a KeyboardKit Pro license is registered, it will unlock new
 properties for resolving a ``CalloutActionProvider`` and an
 ``InputSetProvider`` for each keyboard locale.
 
 Each keyboard locale also has localized content that can be
 accessed with the ``KKL10n`` translation enum.
 
 You can change the locale of a keyboard extension using the
 ``KeyboardContext/locale`` property, which will cause parts
 of the keyboard that needs it to automatically update.
 
 You can change the available locales of keyboard extensions
 using the ``KeyboardContext/locales`` property, which makes
 it possible to navigate through the available locales using
 the ``KeyboardContext/selectNextLocale()`` function.
 */
public enum KeyboardLocale: String,
                            CaseIterable,
                            Codable,
                            Identifiable,
                            LocaleFlagProvider {
    
    case english = "en"
    
    case albanian = "sq"
    case arabic = "ar"
    case armenian = "hy"
    case belarusian = "be"
    case bulgarian = "bg"
    case catalan = "ca"
    case cherokee = "chr"
    case croatian = "hr"
    case czech = "cs"
    case danish = "da"
    case dutch = "nl"
    case dutch_belgium = "nl_BE"
    case english_gb = "en_GB"
    case english_us = "en_US"
    case estonian = "et"
    case faroese = "fo"
    case filipino = "fil"
    case finnish = "fi"
    case french = "fr"
    case french_belgium = "fr_BE"
    case french_switzerland = "fr_CH"
    case georgian = "ka"
    case german = "de"
    case german_austria = "de_AT"
    case german_switzerland = "de_CH"
    case greek = "el"
    case hawaiian = "haw"
    case hebrew = "he_IL"
    case hungarian = "hu"
    case icelandic = "is"
    case indonesian = "id"
    case irish = "ga_IE"
    case italian = "it"
    case kurdish_sorani = "ckb"
    case kurdish_sorani_arabic = "ckb_IQ"
    case kurdish_sorani_pc = "ckb_PC"
    case latvian = "lv"
    case lithuanian = "lt"
    case macedonian = "mk"
    case malay = "ms"
    case maltese = "mt"
    case mongolian = "mn"
    case norwegian = "nb"
    case persian = "fa"
    case polish = "pl"
    case portuguese = "pt_PT"
    case portuguese_brazil = "pt_BR"
    case romanian = "ro"
    case russian = "ru"
    case serbian = "sr"
    case serbian_latin = "sr-Latn"
    case slovak = "sk"
    case slovenian = "sl"
    case spanish = "es"
    case swedish = "sv"
    case swahili = "sw"
    case turkish = "tr"
    case ukrainian = "uk"
    case uzbek = "uz"
}

public extension KeyboardLocale {

    /**
     Get all LTR locales.
     */
    static var allLtr: [KeyboardLocale] {
        allCases.filter { $0.isLeftToRight }
    }

    /**
     Get all RTL locales.
     */
    static var allRtl: [KeyboardLocale] {
        allCases.filter { $0.isRightToLeft }
    }
    
    /**
     The locale's unique identifier.
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

     Note that this property adjusts some locales, where the
     flag should not use the standard result.
     */
    var flag: String {
        switch self {
        case .albanian: return "🇦🇱"
        case .arabic: return "🇦🇪"
        case .armenian: return "🇦🇲"
        case .belarusian: return "🇧🇾"
        case .bulgarian: return "🇧🇬"
        case .catalan: return "🇦🇩"
        case .cherokee: return "🏳️"
        case .croatian: return "🇭🇷"
        case .czech: return "🇨🇿"
        case .danish: return "🇩🇰"

        case .dutch: return "🇳🇱"
        case .dutch_belgium: return "🇧🇪"
        case .english: return "🇺🇸"
        case .english_gb: return "🇬🇧"
        case .english_us: return "🇺🇸"
        case .estonian: return "🇪🇪"
        case .faroese: return "🇫🇴"
        case .filipino: return "🇵🇭"
        case .finnish: return "🇫🇮"
        case .french: return "🇫🇷"

        case .french_belgium: return "🇧🇪"
        case .french_switzerland: return "🇨🇭"
        case .georgian: return "🇬🇪"
        case .german: return "🇩🇪"
        case .german_austria: return "🇦🇹"
        case .german_switzerland: return "🇨🇭"
        case .greek: return "🇬🇷"
        case .hawaiian: return "🇺🇸"
        case .hebrew: return "🇮🇱"
        case .hungarian: return "🇭🇺"

        case .icelandic: return "🇮🇸"
        case .indonesian: return "🇮🇩"
        case .irish: return "🇮🇪"
        case .italian: return "🇮🇹"
        case .kurdish_sorani: return "🇹🇯"
        case .kurdish_sorani_arabic: return "🇹🇯"
        case .kurdish_sorani_pc: return "🇹🇯"
        case .latvian: return "🇱🇻"
        case .lithuanian: return "🇱🇹"
        case .macedonian: return "🇲🇰"

        case .malay: return "🇲🇾"
        case .maltese: return "🇲🇹"
        case .mongolian: return "🇲🇳"
        case .norwegian: return "🇳🇴"
        case .persian: return "🇮🇷"
        case .polish: return "🇵🇱"
        case .portuguese: return "🇵🇹"
        case .portuguese_brazil: return "🇧🇷"
        case .romanian: return "🇷🇴"
        case .russian: return "🇷🇺"

        case .serbian: return "🇷🇸"
        case .serbian_latin: return "🇷🇸"
        case .slovenian: return "🇸🇮"
        case .slovak: return "🇸🇰"
        case .spanish: return "🇪🇸"
        case .swedish: return "🇸🇪"
        case .swahili: return "🇰🇪"
        case .turkish: return "🇹🇷"
        case .ukrainian: return "🇺🇦"
        case .uzbek: return "🇺🇿"
        }
    }
    
    /**
     Whether or not the locale is a left-to-right one.
     */
    var isLeftToRight: Bool { locale.isLeftToRight }

    /**
     Whether or not the locale is a right-to-left one.
     */
    var isRightToLeft: Bool { !isLeftToRight }

    /**
     Whether or not the locale prefers to replace any single
     alternate ending quotation delimiters with begin ones.
     */
    var prefersAlternateQuotationReplacement: Bool {
        locale.prefersAlternateQuotationReplacement
    }

    /**
     Whether or not the locale matches a certain locale.
     */
    func matches(_ locale: Locale) -> Bool {
        self.locale == locale
    }
}

public extension Locale {

    /**
     Whether or not the locale matches a keyboard locale.
     */
    func matches(_ locale: KeyboardLocale) -> Bool {
        self == locale.locale
    }
}

public extension Collection where Element == KeyboardLocale {

    /**
     Get all LTR locales.
     */
    static var allLtr: [KeyboardLocale] {
        KeyboardLocale.allLtr
    }

    /**
     Get all RTL locales.
     */
    static var allRtl: [KeyboardLocale] {
        KeyboardLocale.allRtl
    }
    
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

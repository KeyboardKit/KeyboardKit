//
//  KeyboardLocale.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-01.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This enum defines KeyboardKit-supported locales and is a
/// namespace for locale-elated types.
///
/// Every keyboard locale refers to a native ``locale`` that
/// provide locale-specific information. 
///
/// A keyboard locale also defines localized assets that can
/// be translated with ``KKL10n``.
public enum KeyboardLocale: String, CaseIterable, Codable, Identifiable {
    
    /// Try to map a fuzzy name to a keyboard locale.
    public init?(
        fuzzyName: String
    ) {
        let match = Self.allCases.first { fuzzyName.matches($0) }
        guard let match = match else { return nil }
        self = match
    }
    
    /// Try to get a matching keyboard locale for a locale.
    ///
    /// If no exact match was found, the first locale with a
    /// matching language code is returned.
    public init?(
        for locale: Locale
    ) {
        let exact = KeyboardLocale.all.first { $0.matches(locale) }
        let fuzzy = KeyboardLocale.all.first { $0.matchesLanguage(in: locale) }
        if let match = (exact ?? fuzzy) {
            self = match
        } else {
            return nil
        }
    }
    
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
    case french_canada = "fr_CA"
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
    case inari_sami = "smn"
    case indonesian = "id"
    case irish = "ga_IE"
    case italian = "it"
    case kazakh = "kk"
    case kurdish_sorani = "ckb"
    case kurdish_sorani_arabic = "ckb_IQ"
    case kurdish_sorani_pc = "ckb_PC"
    case latvian = "lv"
    case lithuanian = "lt"
    case macedonian = "mk"
    case malay = "ms"
    case maltese = "mt"
    case mongolian = "mn"
    case northern_sami = "se"
    case norwegian = "nb"
    case norwegian_nynorsk = "nn"
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
    case spanish_latinAmerica = "es_419"
    case spanish_mexico = "es_MX"
    case swedish = "sv"
    case swahili = "sw"
    case turkish = "tr"
    case ukrainian = "uk"
    case uzbek = "uz"
    case welsh = "cy"
}

public extension KeyboardLocale {

    /// Get all locales.
    static var all: [KeyboardLocale] {
        allCases
    }
    
    /// The locale's unique identifier.
    var id: String { rawValue }
    
    /// The raw locale that is used by the keyboard locale.
    var locale: Locale { .init(identifier: localeIdentifier) }
    
    /// The raw locale identifier.
    var localeIdentifier: String { id }
    
    /// The raw locale name, as defined within the library.
    var rawName: String {
        switch self {
        case .albanian: "albanian"
        case .arabic: "arabic"
        case .armenian: "armenian"
        case .belarusian: "belarusian"
        case .bulgarian: "bulgarian"
        case .catalan: "catalan"
        case .cherokee: "cherokee"
        case .croatian: "croatian"
        case .czech: "czech"
        case .danish: "danish"

        case .dutch: "dutch"
        case .dutch_belgium: "dutch_belgium"
        case .english: "english"
        case .english_gb: "english_gb"
        case .english_us: "english_us"
        case .estonian: "estonian"
        case .faroese: "faroese"
        case .filipino: "filipino"
        case .finnish: "finnish"
        case .french: "french"

        case .french_belgium: "french_belgium"
        case .french_canada: "french_canada"
        case .french_switzerland: "french_switzerland"
        case .georgian: "georgian"
        case .german: "german"
        case .german_austria: "german_austria"
        case .german_switzerland: "german_switzerland"
        case .greek: "greek"
        case .hawaiian: "hawaiian"
        case .hebrew: "hebrew"
            
        case .hungarian: "hungarian"
        case .icelandic: "icelandic"
        case .inari_sami: "inari_sami"
        case .indonesian: "indonesian"
        case .irish: "irish"
        case .italian: "italian"
        case .kazakh: "kazakh"
        case .kurdish_sorani: "kurdish_sorani"
        case .kurdish_sorani_arabic: "kurdish_sorani_arabic"
        case .kurdish_sorani_pc: "kurdish_sorani_pc"
        
        case .latvian: "latvian"
        case .lithuanian: "lithuanian"
        case .macedonian: "macedonian"
        case .malay: "malay"
        case .maltese: "maltese"
        case .mongolian: "mongolian"
        case .northern_sami: "northern_sami"
        case .norwegian: "norwegian"
        case .norwegian_nynorsk: "norwegian_nynorsk"
        case .persian: "persian"
            
        case .polish: "polish"
        case .portuguese: "portuguese"
        case .portuguese_brazil: "portuguese_brazil"
        case .romanian: "romanian"
        case .russian: "russian"
        case .serbian: "serbian"
        case .serbian_latin: "serbian_latin"
        case .slovenian: "slovenian"
        case .slovak: "slovak"
        case .spanish: "spanish"
            
        case .spanish_latinAmerica: "spanish_latinAmerica"
        case .spanish_mexico: "spanish_mexico"
        case .swedish: "swedish"
        case .swahili: "swahili"
        case .turkish: "turkish"
        case .ukrainian: "ukrainian"
        case .uzbek: "uzbek"
        case .welsh: "welsh"
        }
    }
    
    /// Whether the locale matches a certain locale.
    func matches(_ locale: Locale) -> Bool {
        self.locale == locale
    }
    
    /// Whether the locale language matches a certain locale.
    func matchesLanguage(in locale: Locale) -> Bool {
        self.locale.languageCode == locale.languageCode
    }
}

public extension Locale {

    /// Whether or not the locale matches a keyboard locale.
    func matches(_ locale: KeyboardLocale) -> Bool {
        self == locale.locale
    }
}

public extension Collection where Element == KeyboardLocale {
    
    /// Get all native locales in the collection
    var locales: [Locale] {
        self.map { $0.locale }
    }
}

public extension Collection where Element == KeyboardLocale {

    /// Insert a certain a locale first in the collection.
    func insertingFirst(_ locale: Element) -> [Element] {
        [locale] + removing(locale)
    }

    /// Remove a certain a locale from the collection.
    func removing(_ locale: Element) -> [Element] {
        filter { $0 != locale }
    }
}

private extension String {
    
    func formattedForLocaleMatch() -> String {
        self.replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: "_", with: "")
            .replacingOccurrences(of: " ", with: "")
            .lowercased()
    }
    
    func matches(_ locale: KeyboardLocale) -> Bool {
        let value = self.formattedForLocaleMatch()
        let rawName = locale.rawName.formattedForLocaleMatch()
        let id = locale.localeIdentifier.formattedForLocaleMatch()
        return value.matches(rawName) || value.matches(id)
    }
    
    func matches(_ string: String) -> Bool {
        caseInsensitiveCompare(string) == .orderedSame
    }
}

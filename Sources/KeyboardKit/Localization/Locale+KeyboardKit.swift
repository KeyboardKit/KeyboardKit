//
//  Locale+KeyboardKit.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-10-09.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

public extension Locale {
    
    /// A list of KeyboardKit supported locales.
    ///
    /// KeyboardKit Pro unlocks localized secondary callouts,
    /// layouts and services for all supported locales.
    static var keyboardKitSupported: [Locale] {
        [
            .english, .albanian, .arabic, .armenian, .belarusian,
            .bulgarian, .catalan, .cherokee, .chuvash, .croatian,
            .czech, .danish, .dutch, .dutch_belgium, .english_australia,
            .english_canada, .english_gb, .english_us, .estonian, .faroese,
            .filipino, .finnish, .french, .french_canada, .french_belgium,
            .french_switzerland, .georgian, .german, .german_austria, .german_switzerland,
            .greek, .hawaiian, .hebrew, .hungarian, .icelandic,
            .inari_sami, .indonesian, .irish, .italian, .kazakh,
            .kurdish_sorani, .kurdish_sorani_arabic, .kurdish_sorani_pc, .latvian, .lithuanian,
            .macedonian, .malay, .maltese, .mongolian, .northern_sami,
            .norwegian, .norwegian_nynorsk, .persian, .polish, .portuguese,
            .portuguese_brazil, .romanian, .russian, .serbian, .serbian_latin,
            .slovak, .slovenian, .spanish, .spanish_latinAmerica, .spanish_mexico,
            .swedish, .swahili, .turkish, .ukrainian, .uzbek,
            .welsh
        ]
    }
}

public extension Collection where Element == Locale {

    static var keyboardKitSupported: [Locale] {
        Element.keyboardKitSupported
    }
}

public extension Locale {

    static var english: Locale { .withId("en") }

    static var albanian: Locale { .withId("sq") }
    static var arabic: Locale { .withId("ar") }
    static var armenian: Locale { .withId("hy") }
    static var belarusian: Locale { .withId("be") }
    static var bulgarian: Locale { .withId("bg") }
    static var catalan: Locale { .withId("ca") }
    static var cherokee: Locale { .withId("chr") }
    static var chuvash: Locale { .withId("cv") }
    static var croatian: Locale { .withId("hr") }
    static var czech: Locale { .withId("cs") }
    static var danish: Locale { .withId("da") }
    static var dutch: Locale { .withId("nl") }
    static var dutch_belgium: Locale { .withId("nl_BE") }
    static var english_australia: Locale { .withId("en_AU") }
    static var english_canada: Locale { .withId("en_CA") }
    static var english_gb: Locale { .withId("en_GB") }
    static var english_us: Locale { .withId("en_US") }
    static var estonian: Locale { .withId("et") }
    static var faroese: Locale { .withId("fo") }
    static var filipino: Locale { .withId("fil") }
    static var finnish: Locale { .withId("fi") }
    static var french: Locale { .withId("fr") }
    static var french_canada: Locale { .withId("fr_CA") }
    static var french_belgium: Locale { .withId("fr_BE") }
    static var french_switzerland: Locale { .withId("fr_CH") }
    static var georgian: Locale { .withId("ka") }
    static var german: Locale { .withId("de") }
    static var german_austria: Locale { .withId("de_AT") }
    static var german_switzerland: Locale { .withId("de_CH") }
    static var greek: Locale { .withId("el") }
    static var hawaiian: Locale { .withId("haw") }
    static var hebrew: Locale { .withId("he_IL") }
    static var hungarian: Locale { .withId("hu") }
    static var icelandic: Locale { .withId("is") }
    static var inari_sami: Locale { .withId("smn") }
    static var indonesian: Locale { .withId("id") }
    static var irish: Locale { .withId("ga_IE") }
    static var italian: Locale { .withId("it") }
    static var kazakh: Locale { .withId("kk") }
    static var kurdish_sorani: Locale { .withId("ckb") }
    static var kurdish_sorani_arabic: Locale { .withId("ckb_IQ") }
    static var kurdish_sorani_pc: Locale { .withId("ckb_PC") }
    static var latvian: Locale { .withId("lv") }
    static var lithuanian: Locale { .withId("lt") }
    static var macedonian: Locale { .withId("mk") }
    static var malay: Locale { .withId("ms") }
    static var maltese: Locale { .withId("mt") }
    static var mongolian: Locale { .withId("mn") }
    static var northern_sami: Locale { .withId("se") }
    static var norwegian: Locale { .withId("nb") }
    static var norwegian_nynorsk: Locale { .withId("nn") }
    static var persian: Locale { .withId("fa") }
    static var polish: Locale { .withId("pl") }
    static var portuguese: Locale { .withId("pt_PT") }
    static var portuguese_brazil: Locale { .withId("pt_BR") }
    static var romanian: Locale { .withId("ro") }
    static var russian: Locale { .withId("ru") }
    static var serbian: Locale { .withId("sr") }
    static var serbian_latin: Locale { .withId("sr-Latn") }
    static var slovak: Locale { .withId("sk") }
    static var slovenian: Locale { .withId("sl") }
    static var spanish: Locale { .withId("es") }
    static var spanish_latinAmerica: Locale { .withId("es_419") }
    static var spanish_mexico: Locale { .withId("es_MX") }
    static var swedish: Locale { .withId("sv") }
    static var swahili: Locale { .withId("sw") }
    static var turkish: Locale { .withId("tr") }
    static var ukrainian: Locale { .withId("uk") }
    static var uzbek: Locale { .withId("uz") }
    static var welsh: Locale { .withId("cy") }
}

public extension Locale {

    /// The KeyboardKit-specific name.
    var keyboardKitName: String {
        switch self {
        case .albanian: "albanian"
        case .arabic: "arabic"
        case .armenian: "armenian"
        case .belarusian: "belarusian"
        case .bulgarian: "bulgarian"
        case .catalan: "catalan"
        case .cherokee: "cherokee"
        case .chuvash: "chuvash"
        case .croatian: "croatian"
        case .czech: "czech"
            
        case .danish: "danish"
        case .dutch: "dutch"
        case .dutch_belgium: "dutch_belgium"
        case .english: "english"
        case .english_australia: "english_australia"
        case .english_canada: "english_canada"
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
            
        default: "-"
        }
    }
}

private extension Locale {

    static func withId(_ id: String) -> Locale {
        .init(identifier: id)
    }
}

#Preview {
    
    let locale = Locale(identifier: "cv")
    
    Text(locale.localizedName(in: .english) ?? "-")
}

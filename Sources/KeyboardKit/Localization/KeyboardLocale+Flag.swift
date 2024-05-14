//
//  Locale+Flag.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-10-27.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

public extension KeyboardLocale {
    
    /// The corresponding flag emoji for the locale.
    var flag: String {
        switch self {
        case .albanian: "🇦🇱"
        case .arabic: "🇦🇪"
        case .armenian: "🇦🇲"
        case .belarusian: "🇧🇾"
        case .bulgarian: "🇧🇬"
        case .catalan: "🇦🇩"
        case .cherokee: "🏳️"
        case .croatian: "🇭🇷"
        case .czech: "🇨🇿"
        case .danish: "🇩🇰"
            
        case .dutch: "🇳🇱"
        case .dutch_belgium: "🇧🇪"
        case .english: "🇺🇸"
        case .english_gb: "🇬🇧"
        case .english_us: "🇺🇸"
        case .estonian: "🇪🇪"
        case .faroese: "🇫🇴"
        case .filipino: "🇵🇭"
        case .finnish: "🇫🇮"
        case .french: "🇫🇷"
            
        case .french_canada: "🇨🇦"
        case .french_belgium: "🇧🇪"
        case .french_switzerland: "🇨🇭"
        case .georgian: "🇬🇪"
        case .german: "🇩🇪"
        case .german_austria: "🇦🇹"
        case .german_switzerland: "🇨🇭"
        case .greek: "🇬🇷"
        case .hawaiian: "🇺🇸"
        case .hebrew: "🇮🇱"
            
        case .hungarian: "🇭🇺"
        case .icelandic: "🇮🇸"
        case .indonesian: "🇮🇩"
        case .irish: "🇮🇪"
        case .italian: "🇮🇹"
        case .kazakh: "🇰🇿"
        case .kurdish_sorani: "🇹🇯"
        case .kurdish_sorani_arabic: "🇹🇯"
        case .kurdish_sorani_pc: "🇹🇯"
        case .latvian: "🇱🇻"
            
        case .lithuanian: "🇱🇹"
        case .macedonian: "🇲🇰"
        case .malay: "🇲🇾"
        case .maltese: "🇲🇹"
        case .mongolian: "🇲🇳"
        case .norwegian: "🇳🇴"
        case .norwegian_nynorsk: "🇳🇴"
        case .persian: "🇮🇷"
        case .polish: "🇵🇱"
        case .portuguese: "🇵🇹"
            
        case .portuguese_brazil: "🇧🇷"
        case .romanian: "🇷🇴"
        case .russian: "🇷🇺"
        case .sami_inari: "🏳️"
        case .sami_northern: "🏳️"
        case .serbian: "🇷🇸"
        case .serbian_latin: "🇷🇸"
        case .slovenian: "🇸🇮"
        case .slovak: "🇸🇰"
        case .spanish: "🇪🇸"
            
        case .spanish_latinAmerica: "🇦🇷"
        case .spanish_mexico: "🇲🇽"
        case .swedish: "🇸🇪"
        case .swahili: "🇰🇪"
        case .turkish: "🇹🇷"
        case .ukrainian: "🇺🇦"
        case .uzbek: "🇺🇿"
        case .welsh: "🏴󠁧󠁢󠁷󠁬󠁳󠁿"
        }
    }
}

@available(iOS 16, macOS 13, tvOS 16, watchOS 9, *)
public extension Locale {

    /**
     Get the locale flag symbol that can be used as an emoji.

     This only works if the locale has a region identifier.
     */
    var flag: String? {
        let regionIdentifier = region?.identifier
        let flagBase = UnicodeScalar("🇦").value - UnicodeScalar("A").value
        let flag = regionIdentifier?
            .uppercased()
            .unicodeScalars
            .compactMap { UnicodeScalar(flagBase + $0.value)?.description }
            .joined()
        return flag ?? ""
    }
}

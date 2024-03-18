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
        case .inariSami: return "🏳️"
        case .indonesian: return "🇮🇩"
        case .irish: return "🇮🇪"
        case .italian: return "🇮🇹"
        case .kazakh: return "🇰🇿"
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
        case .northernSami: return "🏳️"
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

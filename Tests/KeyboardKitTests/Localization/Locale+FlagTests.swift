//
//  Locale+FlagTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-10-09.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class Locale_FlagTests: XCTestCase {

    let locales = Locale.keyboardKitSupported

    func testFlagIsValidForAllSupportedLocales() {
        let expected: [Locale: String] = [
            .albanian: "🇦🇱",
            .arabic: "🇦🇪",
            .armenian: "🇦🇲",
            .belarusian: "🇧🇾",
            .bulgarian: "🇧🇬",
            .catalan: "🇦🇩",
            .cherokee: "🏳️",
            .croatian: "🇭🇷",
            .czech: "🇨🇿",
            .danish: "🇩🇰",
            .dutch: "🇳🇱",
            .dutch_belgium: "🇧🇪",
            .english: "🇺🇸",
            .english_gb: "🇬🇧",
            .english_us: "🇺🇸",
            .estonian: "🇪🇪",
            .faroese: "🇫🇴",
            .filipino: "🇵🇭",
            .finnish: "🇫🇮",
            .french: "🇫🇷",
            .french_belgium: "🇧🇪",
            .french_canada: "🇨🇦",
            .french_switzerland: "🇨🇭",
            .georgian: "🇬🇪",
            .german: "🇩🇪",
            .german_austria: "🇦🇹",
            .german_switzerland: "🇨🇭",
            .greek: "🇬🇷",
            .hawaiian: "🇺🇸",
            .hebrew: "🇮🇱",
            .hungarian: "🇭🇺",
            .icelandic: "🇮🇸",
            .inari_sami: "🏳️",
            .indonesian: "🇮🇩",
            .irish: "🇮🇪",
            .italian: "🇮🇹",
            .kazakh: "🇰🇿",
            .kurdish_sorani: "🇹🇯",
            .kurdish_sorani_arabic: "🇹🇯",
            .kurdish_sorani_pc: "🇹🇯",
            .latvian: "🇱🇻",
            .lithuanian: "🇱🇹",
            .macedonian: "🇲🇰",
            .malay: "🇲🇾",
            .maltese: "🇲🇹",
            .mongolian: "🇲🇳",
            .northern_sami: "🏳️",
            .norwegian: "🇳🇴",
            .norwegian_nynorsk: "🇳🇴",
            .persian: "🇮🇷",
            .polish: "🇵🇱",
            .portuguese: "🇵🇹",
            .portuguese_brazil: "🇧🇷",
            .romanian: "🇷🇴",
            .russian: "🇷🇺",
            .serbian: "🇷🇸",
            .serbian_latin: "🇷🇸",
            .slovenian: "🇸🇮",
            .slovak: "🇸🇰",
            .spanish: "🇪🇸",
            .spanish_latinAmerica: "🇦🇷",
            .spanish_mexico: "🇲🇽",
            .swedish: "🇸🇪",
            .swahili: "🇰🇪",
            .turkish: "🇹🇷",
            .ukrainian: "🇺🇦",
            .uzbek: "🇺🇿",
            .welsh: "🏴󠁧󠁢󠁷󠁬󠁳󠁿"
        ]

        XCTAssertEqual(expected.keys.count, locales.count)
        expected.keys.forEach {
            XCTAssertEqual(expected[$0], $0.flag)
        }
    }
    
    func testPrintHtmlForFlagGrid() throws {
        var count = 0
        var text = ""
        print("")
        print("************************")
        print("*** Locale Flag Grid ***")
        print("************************")
        print("")
        locales.forEach { locale in
            count += 1
            text += "\(locale.flag) "
            if count == 10 {
                printLine(text)
                count = 0
                text = ""
            }
        }
        print("")
    }

    func testPrintHtmlForFlagList() throws {
        print("")
        print("************************")
        print("*** Locale Flag List ***")
        print("************************")
        print("")
        locales.forEach { locale in
            let name = locale.localizedName(in: .english) ?? ""
            printLine("\(locale.flag) \(name)")
        }
        print("")
    }

    func testPrintHtmlForNameList() throws {
        print("")
        print("************************")
        print("*** Locale Name List ***")
        print("************************")
        print("")
        locales.forEach { locale in
            printLine(locale.localizedName(in: .english) ?? "")
        }
        print("")
    }
    
    func printLine(_ string: String) {
        print("\(string) <br />")
    }
}

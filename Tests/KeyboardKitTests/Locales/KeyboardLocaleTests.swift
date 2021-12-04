//
//  KeyboardLocaleTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation
import Quick
import Nimble
import KeyboardKit

class KeyboardLocaleTests: QuickSpec {
    
    override func spec() {
        
        let locales = KeyboardLocale.allCases
        
        describe("locale identifier") {
            
            it("is valid for all cases") {
                let map = locales.map { ($0, $0.id) }
                let result = Dictionary(uniqueKeysWithValues: map)
                expect(result).to(equal(
                    [
                        .albanian: "sq",
                        .danish: "da",
                        .dutch: "nl",
                        .english: "en",
                        .english_gb: "en-GB",
                        .english_us: "en-US",
                        .estonian: "et",
                        .farsi: "fa",
                        .french: "fr",
                        .finnish: "fi",
                        .german: "de",
                        .icelandic: "is",
                        .italian: "it",
                        .latvian: "lv",
                        .lithuanian: "lt",
                        .norwegian: "nb",
                        .polish: "pl",
                        .russian: "ru",
                        .spanish: "es",
                        .swedish: "sv",
                        .ukrainian: "uk"
                    ]
                ))
            }
        }
        
        describe("locale identifier") {
            
            it("is identical to enum id") {
                let map = locales.map { ($0, $0.id == $0.localeIdentifier) }
                let result = Dictionary(uniqueKeysWithValues: map)
                expect(result.allSatisfy { $0.value == true }).to(beTrue())
            }
        }
        
        describe("embedded locale identifier") {
            
            it("is identical to enum id") {
                let map = locales.map { ($0, $0.id == $0.locale.identifier) }
                let result = Dictionary(uniqueKeysWithValues: map)
                expect(result.allSatisfy { $0.value == true }).to(beTrue())
            }
        }
        
        describe("localized name") {
            
            it("is valid for all cases") {
                let map = locales.map { ($0, $0.localizedName) }
                let result = Dictionary(uniqueKeysWithValues: map)
                
                expect(result).to(equal(
                    [
                        .albanian: "shqip",
                        .danish: "dansk",
                        .dutch: "Nederlands",
                        .english: "English",
                        .english_gb: "English (United Kingdom)",
                        .english_us: "English (United States)",
                        .estonian: "eesti",
                        .farsi: "فارسی",
                        .finnish: "suomi",
                        .french: "français",
                        .german: "Deutsch",
                        .icelandic: "íslenska",
                        .italian: "italiano",
                        .latvian: "latviešu",
                        .lithuanian: "lietuvių",
                        .norwegian: "norsk bokmål",
                        .polish: "polski",
                        .russian: "русский",
                        .spanish: "español",
                        .swedish: "svenska",
                        .ukrainian: "українська"
                    ]
                ))
            }
        }
        
        describe("flag") {
            
            it("is valid for all cases") {
                let map = locales.map { ($0, $0.flag) }
                let result = Dictionary(uniqueKeysWithValues: map)
                expect(result).to(equal(
                    [
                        .albanian: "🇦🇱",
                        .danish: "🇩🇰",
                        .dutch: "🇳🇱",
                        .english: "🇺🇸",
                        .english_gb: "🇬🇧",
                        .english_us: "🇺🇸",
                        .estonian: "🇪🇪",
                        .farsi: "🇮🇷",
                        .finnish: "🇫🇮",
                        .french: "🇫🇷",
                        .german: "🇩🇪",
                        .icelandic: "🇮🇸",
                        .italian: "🇮🇹",
                        .latvian: "🇱🇻",
                        .lithuanian: "🇱🇹",
                        .norwegian: "🇳🇴",
                        .polish: "🇵🇱",
                        .russian: "🇷🇺",
                        .spanish: "🇪🇸",
                        .swedish: "🇸🇪",
                        .ukrainian: "🇺🇦"
                    ]
                ))
            }
        }
        
        describe("is LTR") {
            
            it("is correct for all locales but farsi") {
                let map = locales.map { ($0, $0.isLeftToRight) }
                let result = Dictionary(uniqueKeysWithValues: map)
                expect(result).to(equal(
                    [
                        .albanian: true,
                        .danish: true,
                        .dutch: true,
                        .english: true,
                        .english_gb: true,
                        .english_us: true,
                        .estonian: true,
                        .farsi: false,
                        .finnish: true,
                        .french: true,
                        .german: true,
                        .icelandic: true,
                        .italian: true,
                        .latvian: true,
                        .lithuanian: true,
                        .norwegian: true,
                        .polish: true,
                        .russian: true,
                        .spanish: true,
                        .swedish: true,
                        .ukrainian: true
                    ]
                ))
            }
        }
        
        describe("is RTL") {
            
            it("is inverted LTR value") {
                let map = locales.map { ($0, $0.isRightToLeft) }
                let result = Dictionary(uniqueKeysWithValues: map)
                expect(result).to(equal(
                    [
                        .albanian: false,
                        .danish: false,
                        .dutch: false,
                        .english: false,
                        .english_gb: false,
                        .english_us: false,
                        .estonian: false,
                        .farsi: true,
                        .finnish: false,
                        .french: false,
                        .german: false,
                        .icelandic: false,
                        .italian: false,
                        .latvian: false,
                        .lithuanian: false,
                        .norwegian: false,
                        .polish: false,
                        .russian: false,
                        .spanish: false,
                        .swedish: false,
                        .ukrainian: false
                    ]
                ))
            }
        }
        
        describe("sorted") {
            
            it("is sorted by localized name") {
                let locales = KeyboardLocale.allCases.sorted()
                let names = locales.map { $0.localizedName.capitalized }
                expect(names).to(equal([
                    "Dansk",
                    "Deutsch",
                    "Eesti",
                    "English",
                    "English (United Kingdom)",
                    "English (United States)",
                    "Español",
                    "Français",
                    "Italiano",
                    "Latviešu",
                    "Lietuvių",
                    "Nederlands",
                    "Norsk Bokmål",
                    "Polski",
                    "Shqip",
                    "Suomi",
                    "Svenska",
                    "Íslenska",
                    "Русский",
                    "Українська",
                    "فارسی",
                    
                ]))
            }
            
            it("can insert an existing locale firstmost") {
                let locales = KeyboardLocale.allCases.sorted(insertFirst: .english)
                let names = locales.map { $0.localizedName.capitalized }
                expect(names).to(equal([
                    "English",
                    "Dansk",
                    "Deutsch",
                    "Eesti",
                    "English (United Kingdom)",
                    "English (United States)",
                    "Español",
                    "Français",
                    "Italiano",
                    "Latviešu",
                    "Lietuvių",
                    "Nederlands",
                    "Norsk Bokmål",
                    "Polski",
                    "Shqip",
                    "Suomi",
                    "Svenska",
                    "Íslenska",
                    "Русский",
                    "Українська",
                    "فارسی",
                ]))
            }
        }
    }
}

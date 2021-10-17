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
                        .danish: "da",
                        .dutch: "nl",
                        .english: "en",
                        .english_gb: "en-GB",
                        .english_us: "en-US",
                        .estonian: "et",
                        .french: "fr",
                        .finnish: "fi",
                        .german: "de",
                        .italian: "it",
                        .latvian: "lv",
                        .lithuanian: "lt",
                        .norwegian: "nb",
                        .spanish: "es",
                        .swedish: "sv"
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
                        .danish: "dansk",
                        .dutch: "Nederlands",
                        .english: "English",
                        .english_gb: "English (United Kingdom)",
                        .english_us: "English (United States)",
                        .estonian: "eesti",
                        .finnish: "suomi",
                        .french: "français",
                        .german: "Deutsch",
                        .italian: "italiano",
                        .latvian: "latviešu",
                        .lithuanian: "lietuvių",
                        .norwegian: "norsk bokmål",
                        .spanish: "español",
                        .swedish: "svenska"
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
                        .danish: "🇩🇰",
                        .dutch: "🇳🇱",
                        .english: "🇺🇸",
                        .english_gb: "🇬🇧",
                        .english_us: "🇺🇸",
                        .estonian: "🇪🇪",
                        .finnish: "🇫🇮",
                        .french: "🇫🇷",
                        .german: "🇩🇪",
                        .italian: "🇮🇹",
                        .latvian: "🇱🇻",
                        .lithuanian: "🇱🇹",
                        .norwegian: "🇳🇴",
                        .spanish: "🇪🇸",
                        .swedish: "🇸🇪"
                    ]
                ))
            }
        }
        
        describe("is LTR") {
            
            it("is correct for all locales") {
                let map = locales.map { ($0, $0.isLeftToRight) }
                let result = Dictionary(uniqueKeysWithValues: map)
                expect(result).to(equal(
                    [
                        .danish: true,
                        .dutch: true,
                        .english: true,
                        .english_gb: true,
                        .english_us: true,
                        .estonian: true,
                        .finnish: true,
                        .french: true,
                        .german: true,
                        .italian: true,
                        .latvian: true,
                        .lithuanian: true,
                        .norwegian: true,
                        .spanish: true,
                        .swedish: true
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
                        .danish: false,
                        .dutch: false,
                        .english: false,
                        .english_gb: false,
                        .english_us: false,
                        .estonian: false,
                        .finnish: false,
                        .french: false,
                        .german: false,
                        .italian: false,
                        .latvian: false,
                        .lithuanian: false,
                        .norwegian: false,
                        .spanish: false,
                        .swedish: false
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
                    "Suomi",
                    "Svenska"
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
                    "Suomi",
                    "Svenska"
                ]))
            }
        }
    }
}

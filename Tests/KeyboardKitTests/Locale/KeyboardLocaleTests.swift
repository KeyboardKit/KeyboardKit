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
                        .french: "fr",
                        .finnish: "fi",
                        .german: "de",
                        .italian: "it",
                        .norwegian: "nb",
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
                        .finnish: "suomi",
                        .french: "français",
                        .german: "Deutsch",
                        .italian: "italiano",
                        .norwegian: "norsk bokmål",
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
                        .finnish: "🇫🇮",
                        .french: "🇫🇷",
                        .german: "🇩🇪",
                        .italian: "🇮🇹",
                        .norwegian: "🇳🇴",
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
                        .finnish: true,
                        .french: true,
                        .german: true,
                        .italian: true,
                        .norwegian: true,
                        .swedish: true
                    ]
                ))
            }
        }
        
        describe("is RTL") {
            
            it("is inverted LTR value") {
                let map = locales.map { ($0, $0.isRightToLeft != $0.isLeftToRight) }
                let result = Dictionary(uniqueKeysWithValues: map)
                expect(result).to(equal(
                    [
                        .danish: true,
                        .dutch: true,
                        .english: true,
                        .english_gb: true,
                        .english_us: true,
                        .finnish: true,
                        .french: true,
                        .german: true,
                        .italian: true,
                        .norwegian: true,
                        .swedish: true
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
                    "English",
                    "English (United Kingdom)",
                    "English (United States)",
                    "Français",
                    "Italiano",
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
                    "English (United Kingdom)",
                    "English (United States)",
                    "Français",
                    "Italiano",
                    "Nederlands",
                    "Norsk Bokmål",
                    "Suomi",
                    "Svenska"
                ]))
            }
        }
    }
}

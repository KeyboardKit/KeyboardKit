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
        
        describe("locale identifier and keys") {
            
            func result(for locale: KeyboardLocale, expected: String) -> Bool {
                let array = [locale.id, locale.locale.identifier, locale.localeIdentifier]
                return array.allSatisfy { $0 == expected }
            }
            
            it("is valid for all cases") {
                expect(result(for: .danish, expected: "da")).to(beTrue())
                expect(result(for: .dutch, expected: "nl")).to(beTrue())
                expect(result(for: .english, expected: "en")).to(beTrue())
                expect(result(for: .finnish, expected: "fi")).to(beTrue())
                expect(result(for: .german, expected: "de")).to(beTrue())
                expect(result(for: .italian, expected: "it")).to(beTrue())
                expect(result(for: .norwegian, expected: "nb")).to(beTrue())
                expect(result(for: .swedish, expected: "sv")).to(beTrue())
            }
        }
        
        describe("locale identifier and keys") {
            
            func result(for locale: KeyboardLocale) -> String {
                locale.localizedName
            }
            
            it("is valid for all cases") {
                expect(result(for: .danish)).to(equal("dansk"))
                expect(result(for: .dutch)).to(equal("Nederlands"))
                expect(result(for: .english)).to(equal("English"))
                expect(result(for: .finnish)).to(equal("suomi"))
                expect(result(for: .german)).to(equal("Deutsch"))
                expect(result(for: .italian)).to(equal("italiano"))
                expect(result(for: .norwegian)).to(equal("norsk bokmål"))
                expect(result(for: .swedish)).to(equal("svenska"))
            }
        }
        
        describe("flag") {
            
            func result(for locale: KeyboardLocale) -> String {
                locale.flag
            }
            
            it("is valid for all cases") {
                expect(result(for: .danish)).to(equal("🇩🇰"))
                expect(result(for: .dutch)).to(equal("🇳🇱"))
                expect(result(for: .english)).to(equal("🇺🇸"))
                expect(result(for: .finnish)).to(equal("🇫🇮"))
                expect(result(for: .german)).to(equal("🇩🇪"))
                expect(result(for: .italian)).to(equal("🇮🇹"))
                expect(result(for: .norwegian)).to(equal("🇳🇴"))
                expect(result(for: .swedish)).to(equal("🇸🇪"))
            }
        }
        
        describe("sorted by localized name") {
            
            it("is valid for all cases") {
                let locales = KeyboardLocale.allCases.sorted()
                let names = locales.map { $0.localizedName.capitalized }
                expect(names).to(equal([
                    "Dansk",
                    "Deutsch",
                    "English",
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

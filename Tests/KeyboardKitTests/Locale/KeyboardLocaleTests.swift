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
                expect(result(for: .english, expected: "en")).to(beTrue())
                expect(result(for: .finnish, expected: "fi")).to(beTrue())
                expect(result(for: .german, expected: "de")).to(beTrue())
                expect(result(for: .italian, expected: "it")).to(beTrue())
                expect(result(for: .norwegian, expected: "nb")).to(beTrue())
                expect(result(for: .swedish, expected: "sv")).to(beTrue())
            }
        }
        
        describe("flag") {
            
            func result(for locale: KeyboardLocale) -> String {
                locale.flag
            }
            
            it("is valid for all cases") {
                expect(result(for: .danish)).to(equal("🇩🇰"))
                expect(result(for: .english)).to(equal("🇺🇸"))
                expect(result(for: .finnish)).to(equal("🇫🇮"))
                expect(result(for: .german)).to(equal("🇩🇪"))
                expect(result(for: .italian)).to(equal("🇮🇹"))
                expect(result(for: .norwegian)).to(equal("🇳🇴"))
                expect(result(for: .swedish)).to(equal("🇸🇪"))
            }
        }
    }
}

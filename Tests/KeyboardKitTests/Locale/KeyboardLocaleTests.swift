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
        
        describe("locale key") {
            
            func result(for locale: KeyboardLocale) -> String {
                locale.id
            }
            
            it("is valid for all cases") {
                expect(result(for: .english)).to(equal("en"))
                expect(result(for: .german)).to(equal("de"))
                expect(result(for: .italian)).to(equal("it"))
                expect(result(for: .swedish)).to(equal("sv"))
            }
        }
        
        describe("locale") {
            
            func result(for locale: KeyboardLocale) -> String {
                locale.locale.identifier
            }
            
            it("is valid for all cases") {
                expect(result(for: .english)).to(equal("en"))
                expect(result(for: .german)).to(equal("de"))
                expect(result(for: .italian)).to(equal("it"))
                expect(result(for: .swedish)).to(equal("sv"))
            }
        }
        
        describe("locale") {
            
            func result(for locale: KeyboardLocale) -> String {
                locale.locale.identifier
            }
            
            it("is valid for all cases") {
                expect(result(for: .english)).to(equal("en"))
                expect(result(for: .german)).to(equal("de"))
                expect(result(for: .italian)).to(equal("it"))
                expect(result(for: .swedish)).to(equal("sv"))
            }
        }
        
        describe("flag") {
            
            func result(for locale: KeyboardLocale) -> String {
                locale.flag
            }
            
            it("is valid for all cases") {
                expect(result(for: .english)).to(equal("🇺🇸"))
                expect(result(for: .german)).to(equal("🇩🇪"))
                expect(result(for: .italian)).to(equal("🇮🇹"))
                expect(result(for: .swedish)).to(equal("🇸🇪"))
            }
        }
    }
}

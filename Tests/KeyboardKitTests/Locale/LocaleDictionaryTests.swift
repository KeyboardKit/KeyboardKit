//
//  LocaleDictionaryTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-08.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation
import Quick
import Nimble
import KeyboardKit

class LocaleDictionaryTests: QuickSpec {
    
    override func spec() {
        
        var stringDict: LocaleDictionary<String>!
        var intDict: LocaleDictionary<Int>!
        
        beforeEach {
            stringDict = LocaleDictionary(
                [
                    KeyboardLocale.english.id: "English",
                    KeyboardLocale.german.id: "German",
                    KeyboardLocale.italian.id: "Italian",
                    KeyboardLocale.swedish.id: "Swedish"
                ]
            )
            
            intDict = LocaleDictionary(
                [
                    KeyboardLocale.english.id: 1,
                    KeyboardLocale.german.id: 2,
                    KeyboardLocale.italian.id: 3,
                    KeyboardLocale.swedish.id: 4
                ]
            )
        }
        
        describe("locale dictionary") {
            
            it("can be created with any item type") {
                expect(stringDict).toNot(beNil())
                expect(intDict).toNot(beNil())
            }
            
            it("can resolve existing values on locale") {
                let locale = KeyboardLocale.swedish.locale
                expect(stringDict.value(for: locale)).to(equal("Swedish"))
                expect(intDict.value(for: locale)).to(equal(4))
            }
            
            it("returns nil for non-existing locale") {
                let locale = Locale(identifier: "abc")
                expect(stringDict.value(for: locale)).to(beNil())
                expect(intDict.value(for: locale)).to(beNil())
            }
        }
    }
}

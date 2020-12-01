//
//  KeyboardInputSet+EnglishTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import Foundation
import KeyboardKit

class StandardKeyboardInputSetProviderTests: QuickSpec {
    
    override func spec() {
        
        describe("standard keyboard input set provider") {
            
            it("has supported sets for basic English") {
                let provider = StandardKeyboardInputSetProvider(locale: Locale(identifier: "en"))
                expect(provider.alphabeticInputSet).to(equal(.alphabetic_en))
                expect(provider.numericInputSet).to(equal(.numeric_en))
                expect(provider.symbolicInputSet).to(equal(.symbolic_en))
            }
            
            it("has fallback support for specific locale") {
                let provider = StandardKeyboardInputSetProvider(locale: Locale(identifier: "en-US"))
                expect(provider.alphabeticInputSet).to(equal(.alphabetic_en))
                expect(provider.numericInputSet).to(equal(.numeric_en))
                expect(provider.symbolicInputSet).to(equal(.symbolic_en))
            }
            
            it("has fallback support for non-existing locale") {
                let provider = StandardKeyboardInputSetProvider(locale: Locale(identifier: "abcd"))
                expect(provider.alphabeticInputSet).to(equal(.alphabetic_en))
                expect(provider.numericInputSet).to(equal(.numeric_en))
                expect(provider.symbolicInputSet).to(equal(.symbolic_en))
            }
        }
    }
}

//
//  StandardKeyboardInputSetProviderTests.swift
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
            
            func provider(for identifier: String) -> KeyboardInputSetProvider {
                StandardKeyboardInputSetProvider(locale: Locale(identifier: identifier))
            }
            
            it("supports English") {
                let prov = provider(for: "en")
                expect(prov.alphabeticInputSet).to(equal(.alphabetic_en))
                expect(prov.numericInputSet).to(equal(.numeric_en))
                expect(prov.symbolicInputSet).to(equal(.symbolic_en))
            }
            
            it("supports German") {
                let prov = provider(for: "de")
                expect(prov.alphabeticInputSet).to(equal(.alphabetic_de))
                expect(prov.numericInputSet).to(equal(.numeric_de))
                expect(prov.symbolicInputSet).to(equal(.symbolic_de))
            }
            
            it("supports Italian") {
                let prov = provider(for: "it")
                expect(prov.alphabeticInputSet).to(equal(.alphabetic_it))
                expect(prov.numericInputSet).to(equal(.numeric_it))
                expect(prov.symbolicInputSet).to(equal(.symbolic_it))
            }
            
            it("supports Swedish") {
                let prov = provider(for: "sv")
                expect(prov.alphabeticInputSet).to(equal(.alphabetic_sv))
                expect(prov.numericInputSet).to(equal(.numeric_sv))
                expect(prov.symbolicInputSet).to(equal(.symbolic_sv))
            }
            
            it("has fallback support for specific locale") {
                let prov = provider(for: "en-US")
                expect(prov.alphabeticInputSet).to(equal(.alphabetic_en))
                expect(prov.numericInputSet).to(equal(.numeric_en))
                expect(prov.symbolicInputSet).to(equal(.symbolic_en))
            }
            
            it("has fallback support for non-existing locale") {
                let prov = provider(for: "abcd")
                expect(prov.alphabeticInputSet).to(equal(.alphabetic_en))
                expect(prov.numericInputSet).to(equal(.numeric_en))
                expect(prov.symbolicInputSet).to(equal(.symbolic_en))
            }
        }
    }
}

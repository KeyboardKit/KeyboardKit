//
//  StandardKeyboardInputProviderTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import Foundation
import KeyboardKit

class StandardKeyboardInputProviderTests: QuickSpec {
    
    override func spec() {
        
        var provider: KeyboardInputProvider!
        var context: MockKeyboardContext!
        
        beforeEach {
            provider = StandardKeyboardInputProvider()
            context = MockKeyboardContext()
        }
        
        describe("standard keyboard input set provider") {
            
            func alphabetic(for locale: String) -> KeyboardInputSet {
                context.locale = Locale(identifier: locale)
                return provider.alphabeticInputSet(for: context)
            }
            
            func numeric(for locale: String) -> KeyboardInputSet {
                context.locale = Locale(identifier: locale)
                return provider.numericInputSet(for: context)
            }
            
            func symbolic(for locale: String) -> KeyboardInputSet {
                context.locale = Locale(identifier: locale)
                return provider.symbolicInputSet(for: context)
            }
            
            it("supports English") {
                let locale = "en"
                expect(alphabetic(for: locale)).to(equal(.alphabetic_en))
                expect(numeric(for: locale)).to(equal(.numeric_en))
                expect(symbolic(for: locale)).to(equal(.symbolic_en))
            }
            
            it("supports German") {
                let locale = "de"
                expect(alphabetic(for: locale)).to(equal(.alphabetic_de))
                expect(numeric(for: locale)).to(equal(.numeric_de))
                expect(symbolic(for: locale)).to(equal(.symbolic_de))
            }
            
            it("supports Italian") {
                let locale = "it"
                expect(alphabetic(for: locale)).to(equal(.alphabetic_it))
                expect(numeric(for: locale)).to(equal(.numeric_it))
                expect(symbolic(for: locale)).to(equal(.symbolic_it))
            }
            
            it("supports Swedish") {
                let locale = "sv"
                expect(alphabetic(for: locale)).to(equal(.alphabetic_sv))
                expect(numeric(for: locale)).to(equal(.numeric_sv))
                expect(symbolic(for: locale)).to(equal(.symbolic_sv))
            }
            
            it("has fallback support for specific locale") {
                let locale = "en-US"
                expect(alphabetic(for: locale)).to(equal(.alphabetic_en))
                expect(numeric(for: locale)).to(equal(.numeric_en))
                expect(symbolic(for: locale)).to(equal(.symbolic_en))
            }
            
            it("has fallback support for non-existing locale") {
                let locale = "abc"
                expect(alphabetic(for: locale)).to(equal(.alphabetic_en))
                expect(numeric(for: locale)).to(equal(.numeric_en))
                expect(symbolic(for: locale)).to(equal(.symbolic_en))
            }
        }
    }
}

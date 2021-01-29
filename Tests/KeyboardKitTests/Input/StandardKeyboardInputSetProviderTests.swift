//
//  StandardKeyboardInputSetProviderTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import Foundation
import KeyboardKit

class StandardKeyboardInputSetProviderTests: QuickSpec {
    
    override func spec() {
        
        var provider: KeyboardInputSetProvider!
        var context: MockKeyboardContext!
        
        var english: KeyboardInputSetProvider!
        var german: KeyboardInputSetProvider!
        var italian: KeyboardInputSetProvider!
        var swedish: KeyboardInputSetProvider!
        
        beforeEach {
            provider = StandardKeyboardInputSetProvider()
            context = MockKeyboardContext()
            
            english = EnglishKeyboardInputSetProvider()
            german = GermanKeyboardInputSetProvider()
            italian = ItalianKeyboardInputSetProvider()
            swedish = SwedishKeyboardInputSetProvider()
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
                expect(alphabetic(for: locale)).to(equal(english.alphabeticInputSet(for: context)))
                expect(numeric(for: locale)).to(equal(english.numericInputSet(for: context)))
                expect(symbolic(for: locale)).to(equal(english.symbolicInputSet(for: context)))
            }
            
            it("supports German") {
                let locale = "de"
                expect(alphabetic(for: locale)).to(equal(german.alphabeticInputSet(for: context)))
                expect(numeric(for: locale)).to(equal(german.numericInputSet(for: context)))
                expect(symbolic(for: locale)).to(equal(german.symbolicInputSet(for: context)))
            }
            
            it("supports Italian") {
                let locale = "it"
                expect(alphabetic(for: locale)).to(equal(italian.alphabeticInputSet(for: context)))
                expect(numeric(for: locale)).to(equal(italian.numericInputSet(for: context)))
                expect(symbolic(for: locale)).to(equal(italian.symbolicInputSet(for: context)))
            }
            
            it("supports Swedish") {
                let locale = "sv"
                expect(alphabetic(for: locale)).to(equal(swedish.alphabeticInputSet(for: context)))
                expect(numeric(for: locale)).to(equal(swedish.numericInputSet(for: context)))
                expect(symbolic(for: locale)).to(equal(swedish.symbolicInputSet(for: context)))
            }
            
            it("has fallback support for specific locale") {
                let locale = "en-US"
                expect(alphabetic(for: locale)).to(equal(english.alphabeticInputSet(for: context)))
                expect(numeric(for: locale)).to(equal(english.numericInputSet(for: context)))
                expect(symbolic(for: locale)).to(equal(english.symbolicInputSet(for: context)))
            }
            
            it("has fallback support for non-existing locale") {
                let locale = "abc"
                expect(alphabetic(for: locale)).to(equal(english.alphabeticInputSet(for: context)))
                expect(numeric(for: locale)).to(equal(english.numericInputSet(for: context)))
                expect(symbolic(for: locale)).to(equal(english.symbolicInputSet(for: context)))
            }
        }
    }
}

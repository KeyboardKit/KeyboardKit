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
            context = MockKeyboardContext()
            provider = StandardKeyboardInputSetProvider(context: context)
            
            english = EnglishKeyboardInputSetProvider()
            german = GermanKeyboardInputSetProvider()
            italian = ItalianKeyboardInputSetProvider()
            swedish = SwedishKeyboardInputSetProvider()
        }
        
        describe("standard keyboard input set provider") {
            
            func alphabetic(for locale: String) -> KeyboardInputSet {
                context.locale = Locale(identifier: locale)
                return provider.alphabeticInputSet()
            }
            
            func numeric(for locale: String) -> KeyboardInputSet {
                context.locale = Locale(identifier: locale)
                return provider.numericInputSet()
            }
            
            func symbolic(for locale: String) -> KeyboardInputSet {
                context.locale = Locale(identifier: locale)
                return provider.symbolicInputSet()
            }
            
            it("supports English") {
                let locale = "en"
                expect(alphabetic(for: locale)).to(equal(english.alphabeticInputSet()))
                expect(numeric(for: locale)).to(equal(english.numericInputSet()))
                expect(symbolic(for: locale)).to(equal(english.symbolicInputSet()))
            }
            
            it("supports German") {
                let locale = "de"
                expect(alphabetic(for: locale)).to(equal(german.alphabeticInputSet()))
                expect(numeric(for: locale)).to(equal(german.numericInputSet()))
                expect(symbolic(for: locale)).to(equal(german.symbolicInputSet()))
            }
            
            it("supports Italian") {
                let locale = "it"
                expect(alphabetic(for: locale)).to(equal(italian.alphabeticInputSet()))
                expect(numeric(for: locale)).to(equal(italian.numericInputSet()))
                expect(symbolic(for: locale)).to(equal(italian.symbolicInputSet()))
            }
            
            it("supports Swedish") {
                let locale = "sv"
                expect(alphabetic(for: locale)).to(equal(swedish.alphabeticInputSet()))
                expect(numeric(for: locale)).to(equal(swedish.numericInputSet()))
                expect(symbolic(for: locale)).to(equal(swedish.symbolicInputSet()))
            }
            
            it("has fallback support for specific locale") {
                let locale = "en-US"
                expect(alphabetic(for: locale)).to(equal(english.alphabeticInputSet()))
                expect(numeric(for: locale)).to(equal(english.numericInputSet()))
                expect(symbolic(for: locale)).to(equal(english.symbolicInputSet()))
            }
            
            it("has fallback support for non-existing locale") {
                let locale = "abc"
                expect(alphabetic(for: locale)).to(equal(english.alphabeticInputSet()))
                expect(numeric(for: locale)).to(equal(english.numericInputSet()))
                expect(symbolic(for: locale)).to(equal(english.symbolicInputSet()))
            }
        }
    }
}

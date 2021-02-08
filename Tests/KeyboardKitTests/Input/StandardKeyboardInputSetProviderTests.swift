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
        
        var provider: StandardKeyboardInputSetProvider!
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
        
        describe("localized providers") {
            
            it("has standard locale-specific providers") {
                let providers = provider.providerDictionary.dictionary
                expect(providers.keys.count).to(equal(4))
                expect(providers[LocaleKey.english.key] is EnglishKeyboardInputSetProvider).to(beTrue())
                expect(providers[LocaleKey.german.key] is GermanKeyboardInputSetProvider).to(beTrue())
                expect(providers[LocaleKey.italian.key] is ItalianKeyboardInputSetProvider).to(beTrue())
                expect(providers[LocaleKey.swedish.key] is SwedishKeyboardInputSetProvider).to(beTrue())
            }
            
            it("accepts custom providers") {
                provider = StandardKeyboardInputSetProvider(
                    context: context,
                    providers: [EnglishKeyboardInputSetProvider()])
                let providers = provider.providerDictionary.dictionary
                expect(providers.keys.count).to(equal(1))
                expect(providers[LocaleKey.english.key] is EnglishKeyboardInputSetProvider).to(beTrue())
            }
        }
        
        describe("input sets") {
            
            it("supports English") {
                context.locale = Locale(identifier: LocaleKey.english.key)
                expect(provider.alphabeticInputSet()).to(equal(english.alphabeticInputSet()))
                expect(provider.numericInputSet()).to(equal(english.numericInputSet()))
                expect(provider.symbolicInputSet()).to(equal(english.symbolicInputSet()))
            }
            
            it("supports German") {
                context.locale = Locale(identifier: LocaleKey.german.key)
                expect(provider.alphabeticInputSet()).to(equal(german.alphabeticInputSet()))
                expect(provider.numericInputSet()).to(equal(german.numericInputSet()))
                expect(provider.symbolicInputSet()).to(equal(german.symbolicInputSet()))
            }
            
            it("supports Italian") {
                context.locale = Locale(identifier: LocaleKey.italian.key)
                expect(provider.alphabeticInputSet()).to(equal(italian.alphabeticInputSet()))
                expect(provider.numericInputSet()).to(equal(italian.numericInputSet()))
                expect(provider.symbolicInputSet()).to(equal(italian.symbolicInputSet()))
            }
            
            it("supports Swedish") {
                context.locale = Locale(identifier: LocaleKey.swedish.key)
                expect(provider.alphabeticInputSet()).to(equal(swedish.alphabeticInputSet()))
                expect(provider.numericInputSet()).to(equal(swedish.numericInputSet()))
                expect(provider.symbolicInputSet()).to(equal(swedish.symbolicInputSet()))
            }
            
            it("has fallback support for specific locale") {
                context.locale = Locale(identifier: "en-US")
                expect(provider.alphabeticInputSet()).to(equal(english.alphabeticInputSet()))
                expect(provider.numericInputSet()).to(equal(english.numericInputSet()))
                expect(provider.symbolicInputSet()).to(equal(english.symbolicInputSet()))
            }
            
            it("has fallback support for non-supported locale") {
                context.locale = Locale(identifier: "es")
                expect(provider.alphabeticInputSet()).to(equal(english.alphabeticInputSet()))
                expect(provider.numericInputSet()).to(equal(english.numericInputSet()))
                expect(provider.symbolicInputSet()).to(equal(english.symbolicInputSet()))
            }
        }
    }
}

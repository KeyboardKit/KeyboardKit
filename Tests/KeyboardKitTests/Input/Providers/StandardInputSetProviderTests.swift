//
//  StandardInputSetProviderTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS) || os(tvOS)
import Quick
import Nimble
import Foundation
import KeyboardKit

class StandardInputSetProviderTests: QuickSpec {
    
    override func spec() {
        
        var provider: StandardInputSetProvider!
        var context: KeyboardContext!
        
        var english: InputSetProvider!
        
        beforeEach {
            context = KeyboardContext(controller: MockKeyboardInputViewController())
            provider = StandardInputSetProvider(context: context)
            
            english = EnglishInputSetProvider()
        }
        
        describe("localized providers") {
            
            it("has standard locale-specific providers") {
                let providers = provider.providerDictionary.dictionary
                expect(providers.keys.count).to(equal(1))
                expect(providers[KeyboardLocale.english.id] is EnglishInputSetProvider).to(beTrue())
            }
            
            it("accepts custom providers") {
                provider = StandardInputSetProvider(
                    context: context,
                    providers: [EnglishInputSetProvider()])
                let providers = provider.providerDictionary.dictionary
                expect(providers.keys.count).to(equal(1))
                expect(providers[KeyboardLocale.english.id] is EnglishInputSetProvider).to(beTrue())
            }
        }
        
        describe("input sets") {
            
            it("supports English") {
                context.locale = Locale(identifier: KeyboardLocale.english.id)
                expect(provider.alphabeticInputSet).to(equal(english.alphabeticInputSet))
                expect(provider.numericInputSet).to(equal(english.numericInputSet))
                expect(provider.symbolicInputSet).to(equal(english.symbolicInputSet))
            }
            
            it("has fallback support for specific locale") {
                context.locale = Locale(identifier: "en-US")
                expect(provider.alphabeticInputSet).to(equal(english.alphabeticInputSet))
                expect(provider.numericInputSet).to(equal(english.numericInputSet))
                expect(provider.symbolicInputSet).to(equal(english.symbolicInputSet))
            }
            
            it("has fallback support for non-supported locale") {
                context.locale = Locale(identifier: "es")
                expect(provider.alphabeticInputSet).to(equal(english.alphabeticInputSet))
                expect(provider.numericInputSet).to(equal(english.numericInputSet))
                expect(provider.symbolicInputSet).to(equal(english.symbolicInputSet))
            }
        }
    }
}
#endif

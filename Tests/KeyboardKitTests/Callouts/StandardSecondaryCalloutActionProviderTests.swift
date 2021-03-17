//
//  StandardSecondaryCalloutActionProviderTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import Foundation
import KeyboardKit

class StandardSecondaryCalloutActionProviderTests: QuickSpec {
    
    override func spec() {
        
        var provider: StandardSecondaryCalloutActionProvider!
        var context: KeyboardContext!
        
        beforeEach {
            context = KeyboardContext(controller: MockKeyboardInputViewController())
            provider = StandardSecondaryCalloutActionProvider(context: context)
        }
        
        describe("localized providers") {
            
            it("has standard locale-specific providers") {
                let providers = provider.providerDictionary.dictionary
                expect(providers.keys.count).to(equal(1))
                expect(providers[KeyboardLocale.english.id] is EnglishSecondaryCalloutActionProvider).to(beTrue())
            }
            
            it("accepts custom providers") {
                provider = StandardSecondaryCalloutActionProvider(
                    context: context,
                    providers: [EnglishSecondaryCalloutActionProvider()])
                let providers = provider.providerDictionary.dictionary
                expect(providers.keys.count).to(equal(1))
                expect(providers[KeyboardLocale.english.id] is EnglishSecondaryCalloutActionProvider).to(beTrue())
            }
        }
        
        describe("callout actions") {
            
            it("supports English") {
                context.locale = Locale(identifier: KeyboardLocale.english.id)
                let action = KeyboardAction.character("a")
                let actions = provider.secondaryCalloutActions(for: action)
                let expected = "aàáâäæãåā".map { KeyboardAction.character(String($0)) }
                expect(actions).to(equal(expected))
            }
            
            it("has fallback support for specific locale") {
                context.locale = Locale(identifier: "en-US")
                let action = KeyboardAction.character("a")
                let actions = provider.secondaryCalloutActions(for: action)
                let expected = "aàáâäæãåā".map { KeyboardAction.character(String($0)) }
                expect(actions).to(equal(expected))
            }
            
            it("has fallback support for non-supported locale") {
                context.locale = Locale(identifier: KeyboardLocale.german.id)
                let action = KeyboardAction.character("a")
                let actions = provider.secondaryCalloutActions(for: action)
                let expected = "aàáâäæãåā".map { KeyboardAction.character(String($0)) }
                expect(actions).to(equal(expected))
            }
        }
    }
}

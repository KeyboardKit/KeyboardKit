//
//  StandardCalloutActionProviderTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import Foundation
import KeyboardKit

class StandardCalloutActionProviderTests: QuickSpec {
    
    override func spec() {
        
        var provider: StandardCalloutActionProvider!
        var context: KeyboardContext!
        
        beforeEach {
            context = KeyboardContext()
            provider = StandardCalloutActionProvider(context: context)
        }
        
        describe("localized providers") {
            
            it("has standard locale-specific providers") {
                let providers = provider.providerDictionary.dictionary
                expect(providers.keys.count).to(equal(1))
                expect(providers[KeyboardLocale.english.id] is EnglishCalloutActionProvider).to(beTrue())
            }
            
            it("accepts custom providers") {
                provider = StandardCalloutActionProvider(
                    context: context,
                    providers: [StandardCalloutActionProvider.standardProvider])
                let providers = provider.providerDictionary.dictionary
                expect(providers.keys.count).to(equal(1))
                expect(providers[KeyboardLocale.english.id] is EnglishCalloutActionProvider).to(beTrue())
            }
        }
        
        describe("callout actions") {
            
            it("supports English") {
                context.locale = Locale(identifier: KeyboardLocale.english.id)
                let action = KeyboardAction.character("a")
                let actions = provider.calloutActions(for: action)
                let expected = "aàáâäæãåā".map { KeyboardAction.character(String($0)) }
                expect(actions).to(equal(expected))
            }
            
            it("has fallback support for specific locale") {
                context.locale = Locale(identifier: "en-US")
                let action = KeyboardAction.character("a")
                let actions = provider.calloutActions(for: action)
                let expected = "aàáâäæãåā".map { KeyboardAction.character(String($0)) }
                expect(actions).to(equal(expected))
            }
            
            it("has fallback support for non-supported locale") {
                context.locale = Locale(identifier: KeyboardLocale.german.id)
                let action = KeyboardAction.character("a")
                let actions = provider.calloutActions(for: action)
                let expected = "aàáâäæãåā".map { KeyboardAction.character(String($0)) }
                expect(actions).to(equal(expected))
            }
        }
    }
}

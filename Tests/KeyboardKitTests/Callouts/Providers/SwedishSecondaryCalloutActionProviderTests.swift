//
//  SwedishSecondaryCalloutActionProviderTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import Foundation
import KeyboardKit

class SwedishSecondaryCalloutActionProviderTests: QuickSpec {
    
    override func spec() {
        
        var provider: SwedishSecondaryCalloutActionProvider!
        
        beforeEach {
            provider = SwedishSecondaryCalloutActionProvider()
        }
        
        describe("locale") {
            
            it("is correct") {
                expect(provider.localeKey).to(equal("sv"))
            }
        }
        
        describe("callout actions") {
            
            it("appends a kr action firstmost for kr action") {
                let action = KeyboardAction.character("kr")
                let actions = provider.secondaryCalloutActions(for: action)
                expect(actions.first).to(equal(KeyboardAction.character("kr")))
            }
        }
        
        describe("callout actions") {
            
            it("is defined for some actions") {
                let action = KeyboardAction.character("a")
                let actions = provider.secondaryCalloutActions(for: action)
                let expected = "aáàâãā".map { KeyboardAction.character(String($0)) }
                expect(actions).to(equal(expected))
            }
            
            it("is empty for some actions") {
                let action = KeyboardAction.character("å")
                let actions = provider.secondaryCalloutActions(for: action)
                expect(actions).to(equal([]))
            }
        }
    }
}

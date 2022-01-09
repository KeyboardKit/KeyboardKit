//
//  EnglishCalloutActionProviderTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import Foundation
import KeyboardKit

class EnglishCalloutActionProviderTests: QuickSpec {
    
    override func spec() {
        
        var provider: EnglishCalloutActionProvider!
        
        beforeEach {
            provider = try? EnglishCalloutActionProvider()
        }
        
        describe("locale") {
            
            it("is correct") {
                expect(provider.localeKey).to(equal("en"))
            }
        }
        
        describe("callout actions") {
            
            it("is defined for some actions") {
                let action = KeyboardAction.character("a")
                let actions = provider.calloutActions(for: action)
                let expected = "aàáâäæãåā".map { KeyboardAction.character(String($0)) }
                expect(actions).to(equal(expected))
            }
            
            it("is empty for some actions") {
                let action = KeyboardAction.character("å")
                let actions = provider.calloutActions(for: action)
                expect(actions).to(equal([]))
            }
        }
    }
}

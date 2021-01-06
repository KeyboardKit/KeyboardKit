//
//  KeyboardAction+SecondaryCalloutActionsTests.swift
//  KeyboardKitTests
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
        var context: MockKeyboardContext!
        
        beforeEach {
            provider = StandardSecondaryCalloutActionProvider()
            context = MockKeyboardContext()
        }
        
        describe("secondary callout actions") {
            
            func validateResult(for action: KeyboardAction, locale: Locale) -> Bool {
                context.locale = locale
                let providerResult = provider.secondaryCalloutActions(for: action, in: context)
                let actionResult = action.standardSecondaryCalloutActions(for: locale)
                return providerResult == actionResult
            }
            
            it("user standard extension result") {
                let english = Locale(identifier: "en")
                let british = Locale(identifier: "en-GB")
                let swedish = Locale(identifier: "sv")
                expect(validateResult(for: .space, locale: english)).to(beTrue())
                expect(validateResult(for: .character("s"), locale: english)).to(beTrue())
                expect(validateResult(for: .character("s"), locale: swedish)).to(beTrue())
                expect(validateResult(for: .character("a"), locale: british)).to(beTrue())
            }
        }
    }
}

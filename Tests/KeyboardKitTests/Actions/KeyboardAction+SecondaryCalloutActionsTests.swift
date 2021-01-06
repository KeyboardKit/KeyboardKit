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

class KeyboardAction_SecondaryCalloutActionsTests: QuickSpec {
    
    override func spec() {
        
        describe("secondary callout actions") {
            
            func result(for action: KeyboardAction, locale: Locale) -> [KeyboardAction] {
                action.standardSecondaryCalloutActions(for: locale)
            }
            
            func actions(for string: String) -> [KeyboardAction] {
                string.map { .character(String($0)) }
            }
            
            it("has a standard value for some character actions") {
                let english = Locale(identifier: "en")
                let british = Locale(identifier: "en-GB")
                let swedish = Locale(identifier: "sv")
                expect(result(for: .space, locale: english)).to(equal([]))
                expect(result(for: .character("k"), locale: english)).to(equal([]))
                expect(result(for: .character("e"), locale: english)).to(equal(actions(for: "eèéêëēėę")))
                expect(result(for: .character("e"), locale: british)).to(equal(actions(for: "eèéêëēėę")))
                expect(result(for: .character("e"), locale: swedish)).to(equal(actions(for: "eéëèêẽēę")))
                expect(result(for: .character("y"), locale: english)).to(equal(actions(for: "yÿ")))
                expect(result(for: .character("y"), locale: british)).to(equal(actions(for: "yÿ")))
                expect(result(for: .character("y"), locale: swedish)).to(equal([]))
            }
        }
    }
}

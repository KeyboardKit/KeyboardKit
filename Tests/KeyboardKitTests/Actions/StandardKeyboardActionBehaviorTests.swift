//
//  StandardKeyboardActionBehaviorTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-06.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import Mockery
import KeyboardKit
import UIKit

class StandardKeyboardActionBehaviorTests: QuickSpec {
    
    override func spec() {
        
        var behavior: StandardKeyboardActionBehavior!
        
        beforeEach {
            behavior = StandardKeyboardActionBehavior()
        }
        
        describe("should change to alphabetic lowercase") {
            
            func result(for gesture: KeyboardGesture, on action: KeyboardAction, context: KeyboardContext) -> Bool {
                behavior.shouldChangeToAlphabeticLowercase(after: gesture, on: action, for: context)
            }
            
            it("is only true for character tap on uppercased alpha keyboard") {
                let context = MockKeyboardContext()
                context.keyboardType = .alphabetic(.uppercased)
                expect(result(for: .tap, on: .character("i"), context: context)).to(beTrue())
                expect(result(for: .longPress, on: .character("o"), context: context)).to(beFalse())
                expect(result(for: .tap, on: .command, context: context)).to(beFalse())
                context.keyboardType = .alphabetic(.lowercased)
                expect(result(for: .tap, on: .character("s"), context: context)).to(beFalse())
            }
        }
    }
}

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
        var context: MockKeyboardContext!
        var proxy: MockTextDocumentProxy!
        
        beforeEach {
            behavior = StandardKeyboardActionBehavior()
            context = MockKeyboardContext()
            proxy = MockTextDocumentProxy()
            context.textDocumentProxy = proxy
        }
        
        describe("preferred keyboard type after gesture on action") {
            
            func result(for gesture: KeyboardGesture, on action: KeyboardAction, current type: KeyboardType) -> KeyboardType? {
                context.keyboardType = type
                return behavior.preferredKeyboardType(after: gesture, on: action, for: context)
            }
            
            it("is defined for character tap in uppercased alphabetic keyboard") {
                expect(result(for: .tap, on: .character("foo"), current: .alphabetic(.uppercased))).to(equal(KeyboardType.alphabetic(.lowercased)))
                expect(result(for: .tap, on: .character("foo"), current: .alphabetic(.capsLocked))).to(equal(KeyboardType.alphabetic(.capsLocked)))
                expect(result(for: .tap, on: .character("foo"), current: .alphabetic(.lowercased))).to(equal(KeyboardType.alphabetic(.lowercased)))
                expect(result(for: .longPress, on: .character("foo"), current: .symbolic)).to(equal(.symbolic))
            }
        }
        
        
        describe("should end sentence after gesture on action") {
            
            func result(for gesture: KeyboardGesture, on action: KeyboardAction, context: KeyboardContext) -> Bool {
                behavior.shouldEndSentence(after: gesture, on: action, for: context)
            }
            
            it("is only true for space after a previous space") {
                proxy.documentContextBeforeInput = "hej  "
                expect(result(for: .tap, on: .space, context: context)).to(beTrue())
                expect(result(for: .tap, on: .character(" "), context: context)).to(beTrue())
                expect(result(for: .tap, on: .command, context: context)).to(beFalse())
                proxy.documentContextBeforeInput = "hej. "
                expect(result(for: .tap, on: .space, context: context)).to(beFalse())
                expect(result(for: .tap, on: .character(" "), context: context)).to(beFalse())
            }
        }
        
        describe("should switch to alphabetic lowercase after gesture on action") {
            
            func result(for gesture: KeyboardGesture, on action: KeyboardAction, context: KeyboardContext) -> Bool {
                behavior.shouldSwitchToAlphabeticLowercase(after: gesture, on: action, for: context)
            }
            
            it("is only true for character action on uppercased alpha keyboard") {
                context.keyboardType = .alphabetic(.uppercased)
                expect(result(for: .tap, on: .character("i"), context: context)).to(beTrue())
                expect(result(for: .tap, on: .command, context: context)).to(beFalse())
                context.keyboardType = .alphabetic(.lowercased)
                expect(result(for: .tap, on: .character("s"), context: context)).to(beFalse())
            }
        }
    }
}

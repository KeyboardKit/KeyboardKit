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
import UIKit
@testable import KeyboardKit

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
            
            func result(for gesture: KeyboardGesture, on action: KeyboardAction, context: KeyboardContext) -> KeyboardType {
                behavior.preferredKeyboardType(after: gesture, on: action, for: context)
            }
            
            it("is by default the context preferred keyboard type") {
                proxy.documentContextBeforeInput = "Hello!"
                proxy.autocapitalizationType = .allCharacters
                context.keyboardType = .alphabetic(.lowercased)
                expect(result(for: .tap, on: .character("i"), context: context)).to(equal(.alphabetic(.uppercased)))
            }
            
            it("is context preferred keyboard type if shift is double-tapped too slowly") {
                context.keyboardType = .alphabetic(.uppercased)
                behavior.lastShiftCheck = .distantPast
                expect(result(for: .tap, on: .shift(currentState: .uppercased), context: context)).to(equal(.alphabetic(.uppercased)))
            }
            
            it("is context preferred keyboard type if non-shift is double-tapped") {
                context.keyboardType = .alphabetic(.uppercased)
                expect(result(for: .tap, on: .command, context: context)).to(equal(.alphabetic(.lowercased)))
            }
            
            it("is context preferred keyboard type if current keyboard type is not upper-cased") {
                context.keyboardType = .alphabetic(.lowercased)
                expect(result(for: .tap, on: .command, context: context)).to(equal(.alphabetic(.lowercased)))
            }
            
            it("is caps-locked if shift is double-tapped quickly") {
                context.keyboardType = .alphabetic(.uppercased)
                expect(result(for: .tap, on: .shift(currentState: .uppercased), context: context)).to(equal(.alphabetic(.capsLocked)))
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
                proxy.documentContextBeforeInput = "hej.  "
                expect(result(for: .tap, on: .space, context: context)).to(beFalse())
                expect(result(for: .tap, on: .character(" "), context: context)).to(beFalse())
            }
        }
        
        describe("should switch to preferred keyboard type after gesture on action") {
            
            func result(for gesture: KeyboardGesture, on action: KeyboardAction, context: KeyboardContext) -> Bool {
                behavior.shouldSwitchToPreferredKeyboardType(after: gesture, on: action, for: context)
            }
            
            it("is true if the action is shift") {
                expect(result(for: .tap, on: .shift(currentState: .capsLocked), context: context)).to(beTrue())
                expect(result(for: .tap, on: .shift(currentState: .lowercased), context: context)).to(beTrue())
                expect(result(for: .tap, on: .shift(currentState: .uppercased), context: context)).to(beTrue())
            }
            
            it("is true is the current keyboard type differs from the preferred one") {
                proxy.documentContextBeforeInput = "Hello!"
                proxy.autocapitalizationType = .allCharacters
                context.keyboardType = .alphabetic(.lowercased)
                expect(result(for: .tap, on: .character("i"), context: context)).to(beTrue())
            }
            
            it("is false is the current keyboard type is the same as the preferred one") {
                proxy.documentContextBeforeInput = "Hello!"
                proxy.autocapitalizationType = .none
                context.keyboardType = .alphabetic(.lowercased)
                expect(result(for: .tap, on: .character("i"), context: context)).to(beFalse())
            }
        }
    }
}

//
//  StandardKeyboardBehaviorTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import MockingKit
import UIKit
@testable import KeyboardKit

class StandardKeyboardBehaviorTests: QuickSpec {
    
    override func spec() {
        
        var behavior: StandardKeyboardBehavior!
        var context: KeyboardContext!
        var proxy: MockTextDocumentProxy!
        var timer: RepeatGestureTimer!
        
        beforeEach {
            timer = RepeatGestureTimer.shared
            proxy = MockTextDocumentProxy()
            context = KeyboardContext(controller: MockKeyboardInputViewController())
            context.textDocumentProxy = proxy
            behavior = StandardKeyboardBehavior(context: context)
        }
        
        describe("backspace range") {
            
            func result(after seconds: TimeInterval) -> DeleteBackwardRange {
                timer.start {}
                timer.modifyStartDate(to: Date().addingTimeInterval(-seconds))
                return behavior.backspaceRange
            }
            
            it("is char before 3 seconds") {
                expect(result(after: 0)).to(equal(.char))
                expect(result(after: 2.9)).to(equal(.char))
            }
            
            it("is words after 3 seconds") {
                expect(result(after: 3.1)).to(equal(.word))
            }
        }
        
        describe("preferred keyboard type after gesture on action") {
            
            func result(after gesture: KeyboardGesture, on action: KeyboardAction) -> KeyboardType {
                behavior.preferredKeyboardType(after: gesture, on: action)
            }
            
            it("is by default the context preferred keyboard type for tap gesture") {
                proxy.documentContextBeforeInput = "Hello!"
                proxy.autocapitalizationType = .allCharacters
                context.keyboardType = .alphabetic(.lowercased)
                expect(result(after: .tap, on: .character("i"))).to(equal(.alphabetic(.uppercased)))
            }
            
            it("is by default the context current keyboard type for non-tap gesture") {
                proxy.documentContextBeforeInput = "Hello!"
                proxy.autocapitalizationType = .allCharacters
                context.keyboardType = .alphabetic(.lowercased)
                expect(result(after: .press, on: .character("i"))).to(equal(context.keyboardType))
            }
            
            it("is context preferred keyboard type if shift is double-tapped too slowly") {
                context.keyboardType = .alphabetic(.uppercased)
                behavior.lastShiftCheck = .distantPast
                expect(result(after: .tap, on: .shift(currentState: .uppercased))).to(equal(.alphabetic(.uppercased)))
            }
            
            it("is context preferred keyboard type if non-shift is double-tapped") {
                context.keyboardType = .alphabetic(.uppercased)
                expect(result(after: .tap, on: .command)).to(equal(.alphabetic(.lowercased)))
            }
            
            it("is context preferred keyboard type if current keyboard type is not upper-cased") {
                context.keyboardType = .alphabetic(.lowercased)
                expect(result(after: .tap, on: .command)).to(equal(.alphabetic(.lowercased)))
            }
            
            it("is caps-locked if shift is double-tapped quickly") {
                context.keyboardType = .alphabetic(.uppercased)
                expect(result(after: .tap, on: .shift(currentState: .uppercased))).to(equal(.alphabetic(.capsLocked)))
            }
        }
        
        
        describe("should end sentence") {
            
            func result(after gesture: KeyboardGesture, on action: KeyboardAction) -> Bool {
                behavior.shouldEndSentence(after: gesture, on: action)
            }
            
            it("is only true for space after a previous space") {
                proxy.documentContextBeforeInput = "hej  "
                expect(result(after: .tap, on: .space)).to(beTrue())
                expect(result(after: .tap, on: .character(" "))).to(beFalse())
                expect(result(after: .tap, on: .command)).to(beFalse())
                proxy.documentContextBeforeInput = "hej. "
                expect(result(after: .tap, on: .space)).to(beFalse())
                expect(result(after: .tap, on: .character(" "))).to(beFalse())
                proxy.documentContextBeforeInput = "hej.  "
                expect(result(after: .tap, on: .space)).to(beFalse())
                expect(result(after: .tap, on: .character(" "))).to(beFalse())
            }
        }
        
        
        describe("should switch to caps lock") {
            
            func result(after gesture: KeyboardGesture, on action: KeyboardAction) -> Bool {
                behavior.shouldSwitchToCapsLock(after: gesture, on: action)
            }
            
            it("is true if the action is shift") {
                expect(result(after: .tap, on: .shift(currentState: .capsLocked))).to(beTrue())
                expect(result(after: .tap, on: .shift(currentState: .lowercased))).to(beTrue())
                expect(result(after: .tap, on: .shift(currentState: .uppercased))).to(beTrue())
            }
            
            
        }
        
        
        describe("should switch to preferred keyboard type after gesture on action") {
            
            func result(after gesture: KeyboardGesture, on action: KeyboardAction) -> Bool {
                behavior.shouldSwitchToPreferredKeyboardType(after: gesture, on: action)
            }
            
            it("is false if the action is shift") {
                expect(result(after: .tap, on: .shift(currentState: .capsLocked))).to(beTrue())
                expect(result(after: .tap, on: .shift(currentState: .lowercased))).to(beTrue())
                expect(result(after: .tap, on: .shift(currentState: .uppercased))).to(beTrue())
            }
            
            it("is false for most keyboard types") {
                let types: [KeyboardType] = [
                    .custom(named: "foo"),
                    .email,
                    .emojis,
                    .images,
                    .numeric,
                    .symbolic]
                types.forEach {
                    expect(result(after: .tap, on: .keyboardType($0))).to(beFalse())
                }
            }
            
            it("is only true for alphabetic auto-cased keyboard type") {
                let expectedTrue: [KeyboardType] = [
                    .alphabetic(.auto)]
                let expectedFalse: [KeyboardType] = [
                    .alphabetic(.capsLocked),
                    .alphabetic(.lowercased),
                    .alphabetic(.uppercased)]
                expectedTrue.forEach {
                    expect(result(after: .tap, on: .keyboardType($0))).to(beTrue())
                }
                expectedFalse.forEach {
                    expect(result(after: .tap, on: .keyboardType($0))).to(beFalse())
                }
            }
            
            it("is false if the action is keyboard type") {
                let types: [KeyboardType] = [
                    .alphabetic(.lowercased),
                    .custom(named: "foo"),
                    .email,
                    .emojis,
                    .images,
                    .numeric,
                    .symbolic]
                types.forEach {
                    expect(result(after: .tap, on: .keyboardType($0))).to(beFalse())
                }
            }
            
            it("is true is the current keyboard type differs from the preferred one") {
                proxy.documentContextBeforeInput = "Hello!"
                proxy.autocapitalizationType = .allCharacters
                context.keyboardType = .alphabetic(.lowercased)
                expect(result(after: .tap, on: .character("i"))).to(beTrue())
            }
            
            it("is false is the current keyboard type is the same as the preferred one") {
                proxy.documentContextBeforeInput = "Hello!"
                proxy.autocapitalizationType = .none
                context.keyboardType = .alphabetic(.lowercased)
                expect(result(after: .tap, on: .character("i"))).to(beFalse())
            }
            
            it("is false is the current keyboard type is the same as the preferred one") {
                proxy.documentContextBeforeInput = "Hello. "
                context.keyboardType = .symbolic
                expect(result(after: .tap, on: .keyboardType(.numeric))).to(beFalse())
            }
        }
        
        describe("should switch to preferred keyboard type after text did change") {
            
            beforeEach {
                proxy.autocapitalizationType = .sentences
                proxy.documentContextBeforeInput = "foo. "
            }
            
            func result() -> Bool {
                behavior.shouldSwitchToPreferredKeyboardTypeAfterTextDidChange()
            }
            
            it("is true if the the current keyboard type is not the preferred one") {
                expect(result()).to(beTrue())
            }
            
            it("is not true if the current keyboard type is the preferred one") {
                context.keyboardType = .alphabetic(.uppercased)
                expect(result()).to(beFalse())
            }
        }
    }
}

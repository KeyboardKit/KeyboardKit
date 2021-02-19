//
//  KeyboardContext+KeyboardTypeTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import MockingKit
import UIKit

class KeyboardContext_KeyboardTypeTests: QuickSpec {
    
    override func spec() {
        
        var context: KeyboardContext!
        var proxy: MockTextDocumentProxy!
        
        beforeEach {
            proxy = MockTextDocumentProxy()
            context = KeyboardContext(controller: MockKeyboardInputViewController())
            context.textDocumentProxy = proxy
            context.keyboardType = .alphabetic(.lowercased)
        }
        
        describe("preferred keyboard type") {
            
            func result(for current: KeyboardType, preCursorPart: String, type: UITextAutocapitalizationType) -> KeyboardType {
                context.keyboardType = current
                proxy.documentContextBeforeInput = preCursorPart
                proxy.autocapitalizationType = type
                return context.preferredKeyboardType
            }
            
            it("returns correct default type") {
                expect(context.preferredKeyboardType).to(equal(.alphabetic(.lowercased)))
            }
            
            it("returns current type if type is non-alphabetic") {
                context.keyboardType = .symbolic
                expect(result(for: .symbolic, preCursorPart: "", type: .allCharacters)).to(equal(.symbolic))
            }
            
            it("returns correct result for all characters capitalizaton") {
                let current = KeyboardType.alphabetic(.lowercased)
                let type = UITextAutocapitalizationType.allCharacters
                let expected = KeyboardType.alphabetic(.uppercased)
                expect(result(for: current, preCursorPart: "", type: type)).to(equal(expected))
                expect(result(for: current, preCursorPart: "foo", type: type)).to(equal(expected))
                expect(result(for: current, preCursorPart: "foo!", type: type)).to(equal(expected))
                expect(result(for: current, preCursorPart: "foo! ", type: type)).to(equal(expected))
            }
            
            it("always returns caps-locled for caps-locked") {
                let current = KeyboardType.alphabetic(.capsLocked)
                let type = UITextAutocapitalizationType.sentences
                expect(result(for: current, preCursorPart: "", type: type)).to(equal(current))
                expect(result(for: current, preCursorPart: "foo", type: type)).to(equal(current))
                expect(result(for: current, preCursorPart: "foo ", type: type)).to(equal(current))
                expect(result(for: current, preCursorPart: "foo!", type: type)).to(equal(current))
                expect(result(for: current, preCursorPart: "foo! ", type: type)).to(equal(current))
            }
            
            it("returns correct result for sentences capitalizaton") {
                let current = KeyboardType.alphabetic(.lowercased)
                let type = UITextAutocapitalizationType.sentences
                let expected = KeyboardType.alphabetic(.uppercased)
                expect(result(for: current, preCursorPart: "", type: type)).to(equal(expected))
                expect(result(for: current, preCursorPart: "foo", type: type)).to(equal(current))
                expect(result(for: current, preCursorPart: "foo ", type: type)).to(equal(current))
                expect(result(for: current, preCursorPart: "foo!", type: type)).to(equal(expected))
                expect(result(for: current, preCursorPart: "foo! ", type: type)).to(equal(expected))
            }
            
            it("returns correct result for words capitalizaton") {
                let current = KeyboardType.alphabetic(.lowercased)
                let type = UITextAutocapitalizationType.words
                let expected = KeyboardType.alphabetic(.uppercased)
                expect(result(for: current, preCursorPart: "", type: type)).to(equal(expected))
                expect(result(for: current, preCursorPart: "foo", type: type)).to(equal(current))
                expect(result(for: current, preCursorPart: "foo ", type: type)).to(equal(expected))
                expect(result(for: current, preCursorPart: "foo!", type: type)).to(equal(expected))
                expect(result(for: current, preCursorPart: "foo! ", type: type)).to(equal(expected))
            }
            
            it("returns correct result for none capitalizaton") {
                let current = KeyboardType.alphabetic(.lowercased)
                let type = UITextAutocapitalizationType.none
                let expected = KeyboardType.alphabetic(.lowercased)
                expect(result(for: current, preCursorPart: "", type: type)).to(equal(expected))
                expect(result(for: current, preCursorPart: "foo", type: type)).to(equal(expected))
                expect(result(for: current, preCursorPart: "foo!", type: type)).to(equal(expected))
                expect(result(for: current, preCursorPart: "foo! ", type: type)).to(equal(expected))
            }
        }
    }
}

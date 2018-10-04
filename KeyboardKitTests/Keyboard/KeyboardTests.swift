//
//  KeyboardTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2018-10-04.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class KeyboardTests: QuickSpec {
    
    override func spec() {
        
        describe("creating a keyboard") {
            
            var actions: [KeyboardAction]!
            
            beforeEach {
                actions = [.backspace]
            }
            
            context("with actions") {
                
                it("is correctly setup") {
                    let keyboard = Keyboard(actions: actions)
                    expect(keyboard.id).to(beNil())
                    expect(keyboard.actions).to(equal(actions))
                }
            }
            
            context("with id and actions") {
                
                it("is correctly setup") {
                    let keyboard = Keyboard(id: "foo", actions: actions)
                    expect(keyboard.id).to(equal("foo"))
                    expect(keyboard.actions).to(equal(actions))
                }
            }
            
            context("with empty initializer") {
                
                it("is correctly setup") {
                    let keyboard = Keyboard.empty
                    expect(keyboard.actions).to(equal([]))
                }
            }
        }
    }
}

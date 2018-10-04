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
            
            context("without id") {
                
                it("gets correct property values") {
                    let keyboard = Keyboard(actions: actions)
                    expect(keyboard.id).to(equal("keyboard"))
                    expect(keyboard.actions).to(equal(actions))
                }
            }
            
            context("with id") {
                
                it("gets correct property values") {
                    let keyboard = Keyboard(id: "foo", actions: actions)
                    expect(keyboard.id).to(equal("foo"))
                    expect(keyboard.actions).to(equal(actions))
                }
            }
        }
    }
}

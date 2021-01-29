//
//  View+KeyboardTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-29.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import SwiftUI

class View_KeyboardTests: QuickSpec {
    
    override func spec() {
        
        describe("keyboard input view controller") {
            
            it("is the shared instnace") {
                let vc = MockInputViewController()
                KeyboardInputViewController.shared = vc
                let view = Text("")
                expect(view.keyboardInputViewController).to(be(vc))
                expect(Text.keyboardInputViewController).to(be(vc))
            }
        }
    }
}

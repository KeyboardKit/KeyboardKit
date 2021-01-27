//
//  SystemKeyboardButtonTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2020-07-02.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import SwiftUI

class SystemKeyboardButtonTests: QuickSpec {

    override func spec() {
        
        describe("system keyboard button") {
            
            it("can be created with just an action") {
                let button = SystemKeyboardButton(action: .control)
                expect(button).toNot(beNil())
            }
            
            it("can be created with a custom text") {
                let button = SystemKeyboardButton(action: .control, text: "")
                expect(button).toNot(beNil())
            }
            
            it("can be created with a custom image") {
                let button = SystemKeyboardButton(action: .control, image: .command)
                expect(button).toNot(beNil())
            }
        }
    }
}

//
//  SystemKeyboardButtonTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import SwiftUI

class SystemKeyboardButtonTests: QuickSpec {

    override func spec() {
        
        var actionHandler: KeyboardActionHandler!
        var appearance: KeyboardAppearance!
        
        beforeEach {
            let context = KeyboardContext(controller: MockKeyboardInputViewController())
            actionHandler = MockKeyboardActionHandler()
            appearance = StandardKeyboardAppearance(context: context)
        }
        
        describe("system keyboard button") {
            
            it("can be created with just an action") {
                let button = SystemKeyboardButton(
                    action: .control,
                    actionHandler: actionHandler,
                    appearance: appearance)
                expect(button).toNot(beNil())
            }
        }
    }
}

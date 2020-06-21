//
//  StandardKeyboardContextTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import UIKit

class StandardKeyboardContextTests: QuickSpec {
    
    override func spec() {
        
        var actionHandler: KeyboardActionHandler!
        
        beforeEach {
            actionHandler = MockKeyboardActionHandler()
        }
        
        describe("context") {
            
            it("can be created with params") {
                let context = StandardKeyboardContext(
                    actionHandler: actionHandler,
                    keyboardType: .images
                )
                expect(context.actionHandler).to(be(actionHandler))
                expect(context.keyboardType).to(equal(.images))
            }
        }
    }
}

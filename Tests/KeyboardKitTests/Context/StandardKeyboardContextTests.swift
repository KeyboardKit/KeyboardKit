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
        
        describe("context") {
            
            it("can be created with params") {
                let context = StandardKeyboardContext(keyboardType: .images)
                expect(context.keyboardType).to(equal(.images))
            }
        }
    }
}

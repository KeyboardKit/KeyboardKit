//
//  CGFloat+KeyboardTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-07-05.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class CGFloat_KeyboardTests: QuickSpec {
    
    override func spec() {
        
        describe("standard keyboard height") {
            
            it("is 50 points") {
                let height = CGFloat.standardKeyboardRowHeight
                expect(height).to(equal(50))
            }
        }
    }
}

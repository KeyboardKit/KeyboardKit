//
//  KeyboardSpacerViewTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class KeyboardSpacerViewTests: QuickSpec {
    
    override func spec() {
        
        var view: KeyboardSpacerView!
        
        beforeEach {
            view = KeyboardSpacerView(width: 123)
        }
        
        describe("created instance") {
            
            it("is correctly configured") {
                expect(view.width).to(equal(123))
                expect(view.widthConstraint?.constant).to(equal(123))
                expect(view.frame).to(equal(.zero))
            }
        }
        
        describe("intrinsic content size") {
            
            it("uses width constraing") {
                let width = view.intrinsicContentSize.width
                expect(width).to(equal(123))
            }
        }
    }
}

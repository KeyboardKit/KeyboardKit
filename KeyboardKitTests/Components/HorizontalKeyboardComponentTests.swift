//
//  HorizontalKeyboardComponentTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class HorizontalKeyboardComponentTests: QuickSpec {
    
    override func spec() {
        
        var view: TestClass!
        
        beforeEach {
            view = TestClass()
        }
        
        describe("width constraint") {
            
            it("is nil by default") {
                expect(view.widthConstraint).to(beNil())
            }
        }
        
        describe("getting width") {
            
            it("returns intrinsic content width if constraint is nil") {
                expect(view.width).to(equal(123))
            }
            
            it("returns constraint width if it is set") {
                view.width = 21
                expect(view.width).to(equal(21))
            }
        }
        
        describe("setting width") {
            
            it("creates width constraint if needed") {
                view.width = 21
                expect(view.widthConstraint).toNot(beNil())
            }
            
            it("reuses width constraint if needed") {
                view.width = 21
                let constraint1 = view.widthConstraint
                view.width = 25
                let constraint2 = view.widthConstraint
                expect(constraint1).to(be(constraint2))
            }
            
            it("sets width constraint propertoes") {
                view.width = 21
                let constraint = view.widthConstraint
                expect(constraint?.priority).to(equal(.defaultLow))
                expect(constraint?.constant).to(equal(21))
                expect(constraint?.isActive).to(beTrue())
            }
        }
    }
}

private class TestClass: UIView, HorizontalKeyboardComponent {
    
    var widthConstraint: NSLayoutConstraint?
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 123, height: 456)
    }
}

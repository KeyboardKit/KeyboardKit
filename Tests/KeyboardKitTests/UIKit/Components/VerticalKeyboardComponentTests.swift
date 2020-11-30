//
//  VerticalKeyboardComponentTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import UIKit

class VerticalKeyboardComponentTests: QuickSpec {
    
    override func spec() {
        
        var view: TestClass!
        
        beforeEach {
            view = TestClass()
        }
        
        describe("height") {
            
            it("constraint is nil by default") {
                expect(view.heightConstraint).to(beNil())
            }
            
            describe("getting height") {
                
                it("returns intrinsic content height if constraint is nil") {
                    expect(view.height).to(equal(123))
                }
                
                it("returns constraint height if it is set") {
                    view.height = 21
                    expect(view.height).to(equal(21))
                }
            }
            
            describe("setting height") {
                
                it("creates height constraint if needed") {
                    view.height = 21
                    expect(view.heightConstraint).toNot(beNil())
                }
                
                it("reuses height constraint if needed") {
                    view.height = 21
                    let constraint1 = view.heightConstraint
                    view.height = 25
                    let constraint2 = view.heightConstraint
                    expect(constraint1).to(be(constraint2))
                }
                
                it("sets height constraint propertoes") {
                    view.height = 21
                    let constraint = view.heightConstraint
                    expect(constraint?.priority).to(equal(.defaultHigh))
                    expect(constraint?.constant).to(equal(21))
                    expect(constraint?.isActive).to(beTrue())
                }
            }
        }
    }
}

private class TestClass: UIView, VerticalKeyboardComponent {
    
    var heightConstraint: NSLayoutConstraint?
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 456, height: 123)
    }
}

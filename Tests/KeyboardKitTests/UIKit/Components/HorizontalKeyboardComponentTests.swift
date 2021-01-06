//
//  HorizontalKeyboardComponentTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import CoreGraphics
import UIKit
@testable import KeyboardKit

class HorizontalKeyboardComponentTests: QuickSpec {
    
    override func spec() {
        
        var view: TestClass!
        
        beforeEach {
            view = TestClass()
        }
        
        describe("width") {
            
            it("constraint is nil by default") {
                expect(view.widthConstraint).to(beNil())
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
}

private class TestClass: UIView, HorizontalKeyboardComponent {
    
    var widthConstraint: NSLayoutConstraint?
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 123, height: 456)
    }
}

private extension CGRect {
    
    static var landscape: CGRect {
        CGRect(x: 0, y: 0, width: 2, height: 1)
    }
    
    static var portrait: CGRect {
        CGRect(x: 0, y: 0, width: 1, height: 2)
    }
}

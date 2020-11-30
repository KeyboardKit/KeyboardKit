//
//  KeyboardButtonRowComponentTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import CoreGraphics
import UIKit
@testable import KeyboardKit

class KeyboardButtonRowComponentTests: QuickSpec {
    
    override func spec() {
        
        describe("standard row padding") {
            
            it("is correct for iPhone Portrait") {
                expect(TestClass.standardInsets(for: .phone, bounds: .portrait)).to(equal(.horizontal(3, vertical: 6)))
            }
            
            it("is correct for iPhone Landscape") {
                expect(TestClass.standardInsets(for: .phone, bounds: .landscape)).to(equal(.horizontal(3, vertical: 4)))
            }
            
            it("is correct for iPad Portrait") {
                expect(TestClass.standardInsets(for: .pad, bounds: .portrait)).to(equal(.all(5)))
            }
            
            it("is correct for iPad Landscape") {
                expect(TestClass.standardInsets(for: .pad, bounds: .landscape)).to(equal(.all(5)))
            }
        }
    }
}

private class TestClass: UIView, KeyboardButtonRowComponent {
    
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

private extension UIEdgeInsets {
    
    static func all(_ all: CGFloat) -> UIEdgeInsets {
        self.init(top: all, left: all, bottom: all, right: all)
    }
    
    static func horizontal(_ horizontal: CGFloat, vertical: CGFloat) -> UIEdgeInsets {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}

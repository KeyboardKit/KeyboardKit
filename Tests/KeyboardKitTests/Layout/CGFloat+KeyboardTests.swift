//
//  CGFloat+KeyboardsTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-11-30.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import UIKit
@testable import KeyboardKit

class CGFloat_KeyboardTests: QuickSpec {
    
    override func spec() {
        
        describe("standard keyboard row height") {
            
            func result(for idiom: UIUserInterfaceIdiom, orientation: UIInterfaceOrientation) -> CGFloat {
                .standardKeyboardRowHeight(for: idiom, orientation: orientation)
            }
            
            it("is correct for iPhone Portrait") {
                expect(result(for: .phone, orientation: .portrait)).to(equal(54))
            }
            
            it("is correct for iPhone Landscape") {
                expect(result(for: .phone, orientation: .landscapeLeft)).to(equal(38))
            }
            
            it("is correct for iPad Portrait") {
                expect(result(for: .pad, orientation: .portrait)).to(equal(66))
            }
            
            it("is correct for iPad Landscape") {
                expect(result(for: .pad, orientation: .landscapeRight)).to(equal(86))
            }
        }
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

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
        
        describe("standard keyboard button corner radius constants") {
            
            func result(for value: CGFloat) -> CGFloat { value }
            
            it("is correct for iPad Landscape") {
                expect(result(for: .standardKeyboardButtonCornerRadiusForPadLandscape)).to(equal(4))
            }
            
            it("is correct for iPad Portrait") {
                expect(result(for: .standardKeyboardButtonCornerRadiusForPadPortrait)).to(equal(4))
            }
            
            it("is correct for iPhone Landscape") {
                expect(result(for: .standardKeyboardButtonCornerRadiusForPhoneLandscape)).to(equal(4))
            }
            
            it("is correct for iPhone Portrait") {
                expect(result(for: .standardKeyboardButtonCornerRadiusForPhonePortrait)).to(equal(4))
            }
        }
        
        
        describe("standard keyboard button corner radius for idom, orientation and screen size") {
            
            func result(for idiom: UIUserInterfaceIdiom, orientation: UIInterfaceOrientation) -> CGFloat {
                .standardKeyboardButtonCornerRadius(for: idiom, in: orientation, withScreenSize: .zero)
            }
            
            it("is correct for iPad Landscape") {
                expect(result(for: .pad, orientation: .landscapeRight)).to(equal(4))
            }
            
            it("is correct for iPad Portrait") {
                expect(result(for: .pad, orientation: .portrait)).to(equal(4))
            }
            
            it("is correct for iPhone Landscape") {
                expect(result(for: .phone, orientation: .landscapeLeft)).to(equal(4))
            }
            
            it("is correct for iPhone Portrait") {
                expect(result(for: .phone, orientation: .portrait)).to(equal(4))
            }
        }
        
        describe("standard keyboard row height constants") {
            
            func result(for value: CGFloat) -> CGFloat { value }
            
            it("is correct for iPad Landscape") {
                expect(result(for: .standardKeyboardRowHeightForPadLandscape)).to(equal(86))
            }
            
            it("is correct for iPad Portrait") {
                expect(result(for: .standardKeyboardRowHeightForPadPortrait)).to(equal(67))
            }
            
            it("is correct for iPhone Landscape") {
                expect(result(for: .standardKeyboardRowHeightForPhoneLandscape)).to(equal(40))
            }
            
            it("is correct for iPhone Portrait") {
                expect(result(for: .standardKeyboardRowHeightForPhonePortrait)).to(equal(54))
            }
        }
        
        describe("standard keyboard row height for idom, orientation and screen size") {
            
            func result(for idiom: UIUserInterfaceIdiom, orientation: UIInterfaceOrientation) -> CGFloat {
                .standardKeyboardRowHeight(for: idiom, in: orientation, withScreenSize: .zero)
            }
            
            it("is correct for iPad Landscape") {
                expect(result(for: .pad, orientation: .landscapeRight)).to(equal(86))
            }
            
            it("is correct for iPad Portrait") {
                expect(result(for: .pad, orientation: .portrait)).to(equal(67))
            }
            
            it("is correct for iPhone Landscape") {
                expect(result(for: .phone, orientation: .landscapeLeft)).to(equal(40))
            }
            
            it("is correct for iPhone Portrait") {
                expect(result(for: .phone, orientation: .portrait)).to(equal(54))
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

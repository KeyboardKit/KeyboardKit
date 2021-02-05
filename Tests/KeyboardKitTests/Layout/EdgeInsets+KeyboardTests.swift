//
//  EdgeInsets+KeyboardsTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-11-30.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import UIKit
@testable import KeyboardKit

class UIEdgeInsets_KeyboardTests: QuickSpec {
    
    override func spec() {
        
        describe("standard keyboard button padding") {
            
            func result(for idiom: UIUserInterfaceIdiom, orientation: UIInterfaceOrientation) -> UIEdgeInsets {
                .standardKeyboardButtonInsets(for: idiom, orientation: orientation)
            }
            
            it("is correct for iPhone Portrait") {
                expect(result(for: .phone, orientation: .portrait)).to(equal(.horizontal(3, vertical: 6)))
            }
            
            it("is correct for iPhone Landscape") {
                expect(result(for: .phone, orientation: .landscapeLeft)).to(equal(.horizontal(3, vertical: 4)))
            }
            
            it("is correct for iPad Portrait") {
                expect(result(for: .pad, orientation: .portrait)).to(equal(.horizontal(6, vertical: 4.5)))
            }
            
            it("is correct for iPad Landscape") {
                expect(result(for: .pad, orientation: .landscapeRight)).to(equal(.horizontal(7, vertical: 6)))
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

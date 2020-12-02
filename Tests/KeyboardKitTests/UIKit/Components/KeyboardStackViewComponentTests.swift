//
//  KeyboardStackViewComponentTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2020-11-30.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import UIKit
@testable import KeyboardKit

class KeyboardStackViewComponentTests: QuickSpec {
    
    override func spec() {
        
        describe("standard height") {
            
            it("is correct for iPhone Portrait") {
                expect(KeyboardButtonRow.standardHeight(for: .phone, orientation: .portrait)).to(equal(54))
            }
            
            it("is correct for iPhone Landscape") {
                expect(KeyboardButtonRow.standardHeight(for: .phone, orientation: .landscapeLeft)).to(equal(38))
            }
            
            it("is correct for iPad Portrait") {
                expect(KeyboardButtonRow.standardHeight(for: .pad, orientation: .portrait)).to(equal(66))
            }
            
            it("is correct for iPad Landscape") {
                expect(KeyboardButtonRow.standardHeight(for: .pad, orientation: .landscapeRight)).to(equal(86))
            }
        }
    }
}

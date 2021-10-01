//
//  KeyboardLayoutConfigurationTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import UIKit

class KeyboardLayoutConfigurationTests: QuickSpec {
    
    override func spec() {
        
        describe("standard configuration constant") {
            
            it("is correct for iPad Landscape") {
                let config = KeyboardLayoutConfiguration.standardForPadLandscape
                expect(config.buttonCornerRadius).to(equal(4))
                expect(config.buttonInsets).to(equal(.horizontal(7, vertical: 6)))
                expect(config.rowHeight).to(equal(86))
            }
            
            it("is correct for iPad Portrait") {
                let config = KeyboardLayoutConfiguration.standardForPadPortrait
                expect(config.buttonCornerRadius).to(equal(4))
                expect(config.buttonInsets).to(equal(.horizontal(6, vertical: 6)))
                expect(config.rowHeight).to(equal(67))
            }
            
            it("is correct for iPhone Landscape") {
                let config = KeyboardLayoutConfiguration.standardForPhoneLandscape
                expect(config.buttonCornerRadius).to(equal(4))
                expect(config.buttonInsets).to(equal(.horizontal(3, vertical: 4)))
                expect(config.rowHeight).to(equal(40))
            }
            
            it("is correct for iPhone Portrait") {
                let config = KeyboardLayoutConfiguration.standardForPhonePortrait
                expect(config.buttonCornerRadius).to(equal(4))
                expect(config.buttonInsets).to(equal(.horizontal(3, vertical: 6)))
                expect(config.rowHeight).to(equal(54))
            }
        }
        
        describe("standard configuration constant for params") {
            
            func config(
                for idiom: UIUserInterfaceIdiom,
                orientation: UIInterfaceOrientation) -> KeyboardLayoutConfiguration {
                .standard(for: idiom, in: orientation, withScreenSize: .zero)
            }
            
            it("is correct for iPad Landscape") {
                let config = config(for: .pad, orientation: .landscapeRight)
                expect(config.buttonCornerRadius).to(equal(4))
                expect(config.buttonInsets).to(equal(.horizontal(7, vertical: 6)))
                expect(config.rowHeight).to(equal(86))
            }
            
            it("is correct for iPad Portrait") {
                let config = config(for: .pad, orientation: .portrait)
                expect(config.buttonCornerRadius).to(equal(4))
                expect(config.buttonInsets).to(equal(.horizontal(6, vertical: 6)))
                expect(config.rowHeight).to(equal(67))
            }
            
            it("is correct for iPhone Landscape") {
                let config = config(for: .phone, orientation: .landscapeLeft)
                expect(config.buttonCornerRadius).to(equal(4))
                expect(config.buttonInsets).to(equal(.horizontal(3, vertical: 4)))
                expect(config.rowHeight).to(equal(40))
            }
            
            it("is correct for iPhone Portrait") {
                let config = config(for: .phone, orientation: .portrait)
                expect(config.buttonCornerRadius).to(equal(4))
                expect(config.buttonInsets).to(equal(.horizontal(3, vertical: 6)))
                expect(config.rowHeight).to(equal(54))
            }
        }
    }
}


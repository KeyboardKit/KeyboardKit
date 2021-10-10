//
//  KeyboardLayoutConfigurationTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import UIKit
@testable import KeyboardKit

class KeyboardLayoutConfigurationTests: QuickSpec {
    
    override func spec() {
        
        describe("standard configuration constant") {
            
            it("is correct for iPad in landscape") {
                let config = KeyboardLayoutConfiguration.standardPadLandscape
                expect(config.buttonCornerRadius).to(equal(6))
                expect(config.buttonInsets).to(equal(.horizontal(7, vertical: 6)))
                expect(config.rowHeight).to(equal(86))
            }
            
            it("is correct for iPad in portrait") {
                let config = KeyboardLayoutConfiguration.standardPadPortrait
                expect(config.buttonCornerRadius).to(equal(6))
                expect(config.buttonInsets).to(equal(.horizontal(6, vertical: 6)))
                expect(config.rowHeight).to(equal(67))
            }
            
            it("is correct for iPhone in landscape") {
                let config = KeyboardLayoutConfiguration.standardPhoneLandscape
                expect(config.buttonCornerRadius).to(equal(4))
                expect(config.buttonInsets).to(equal(.horizontal(3, vertical: 4)))
                expect(config.rowHeight).to(equal(40))
            }
            
            it("is correct for iPhone in portrait") {
                let config = KeyboardLayoutConfiguration.standardPhonePortrait
                expect(config.buttonCornerRadius).to(equal(4))
                expect(config.buttonInsets).to(equal(.horizontal(3, vertical: 6)))
                expect(config.rowHeight).to(equal(54))
            }
            
            it("is correct for iPhone Pro Max in landscape") {
                let config = KeyboardLayoutConfiguration.standardPhoneProMaxLandscape
                expect(config.buttonCornerRadius).to(equal(4))
                expect(config.buttonInsets).to(equal(.horizontal(3, vertical: 4)))
                expect(config.rowHeight).to(equal(40))
            }
            
            it("is correct for iPhone Pro Max in portrait") {
                let config = KeyboardLayoutConfiguration.standardPhoneProMaxPortrait
                expect(config.buttonCornerRadius).to(equal(6))
                expect(config.buttonInsets).to(equal(.horizontal(3, vertical: 5)))
                expect(config.rowHeight).to(equal(60))
            }
        }
        
        describe("standard keyboard configuration") {
            
            func config(
                forIdiom idiom: UIUserInterfaceIdiom,
                size: CGSize,
                orientation: UIInterfaceOrientation) -> KeyboardLayoutConfiguration {
                KeyboardLayoutConfiguration.standard(
                    forIdiom: idiom,
                    screenSize: size,
                    orientation: orientation
                )
            }
            
            context("for iPad") {
                
                it("is correct for landscape") {
                    let config = config(forIdiom: .pad, size: .iPadScreenLandscape, orientation: .landscapeRight)
                    expect(config.buttonCornerRadius).to(equal(6))
                    expect(config.buttonInsets).to(equal(.horizontal(7, vertical: 6)))
                    expect(config.rowHeight).to(equal(86))
                }
                
                it("is correct for portrait") {
                    let config = config(forIdiom: .pad, size: .iPadScreenPortrait, orientation: .portrait)
                    expect(config.buttonCornerRadius).to(equal(6))
                    expect(config.buttonInsets).to(equal(.horizontal(6, vertical: 6)))
                    expect(config.rowHeight).to(equal(67))
                }
            }
            
            context("for large iPad Pro") {
                
                it("is correct for landscape") {
                    let config = config(forIdiom: .pad, size: .iPadProLargeScreenLandscape, orientation: .landscapeRight)
                    expect(config.buttonCornerRadius).to(equal(6))
                    expect(config.buttonInsets).to(equal(.horizontal(7, vertical: 6)))
                    expect(config.rowHeight).to(equal(86))
                }
                
                it("is correct for portrait") {
                    let config = config(forIdiom: .pad, size: .iPadProLargeScreenPortrait, orientation: .portrait)
                    expect(config.buttonCornerRadius).to(equal(6))
                    expect(config.buttonInsets).to(equal(.horizontal(6, vertical: 6)))
                    expect(config.rowHeight).to(equal(67))
                }
            }
            
            context("for small iPad Pro") {
                
                it("is correct for landscape") {
                    let config = config(forIdiom: .pad, size: .iPadProSmallScreenLandscape, orientation: .landscapeRight)
                    expect(config.buttonCornerRadius).to(equal(6))
                    expect(config.buttonInsets).to(equal(.horizontal(7, vertical: 6)))
                    expect(config.rowHeight).to(equal(86))
                }
                
                it("is correct for portrait") {
                    let config = config(forIdiom: .pad, size: .iPadProSmallScreenPortrait, orientation: .portrait)
                    expect(config.buttonCornerRadius).to(equal(6))
                    expect(config.buttonInsets).to(equal(.horizontal(6, vertical: 6)))
                    expect(config.rowHeight).to(equal(67))
                }
            }
            
            context("for iPhone") {
                
                it("is correct for landscape") {
                    let config = config(forIdiom: .phone, size: .zero, orientation: .landscapeRight)
                    expect(config.buttonCornerRadius).to(equal(4))
                    expect(config.buttonInsets).to(equal(.horizontal(3, vertical: 4)))
                    expect(config.rowHeight).to(equal(40))
                }
                
                it("is correct for portrait") {
                    let config = config(forIdiom: .phone, size: .zero, orientation: .portrait)
                    expect(config.buttonCornerRadius).to(equal(4))
                    expect(config.buttonInsets).to(equal(.horizontal(3, vertical: 6)))
                    expect(config.rowHeight).to(equal(54))
                }
            }
            
            context("for iPhone Pro Max") {
                
                it("is correct for landscape") {
                    let config = config(forIdiom: .phone, size: .zero, orientation: .landscapeRight)
                    expect(config.buttonCornerRadius).to(equal(4))
                    expect(config.buttonInsets).to(equal(.horizontal(3, vertical: 4)))
                    expect(config.rowHeight).to(equal(40))
                }
                
                it("is correct for portrait") {
                    let config = config(forIdiom: .phone, size: .iPhoneProMaxScreenLandscape, orientation: .portrait)
                    expect(config.buttonCornerRadius).to(equal(6))
                    expect(config.buttonInsets).to(equal(.horizontal(3, vertical: 5)))
                    expect(config.rowHeight).to(equal(60))
                }
            }
        }
    }
}

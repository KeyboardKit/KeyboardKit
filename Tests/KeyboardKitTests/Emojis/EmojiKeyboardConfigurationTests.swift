//
//  EmojiKeyboardConfigurationTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import Quick
import Nimble
import KeyboardKit

class EmojiKeyboardConfigurationTests: QuickSpec {
    
    override func spec() {
        
        describe("standard configuration list") {
            
            func validate(_ config: EmojiKeyboardStyle, _ itemSize: CGFloat, _ rows: Int, _ horizontalSpacing: CGFloat, _ verticalSpacing: CGFloat) {
                expect(config.itemSize).to(equal(itemSize))
                expect(config.rows).to(equal(rows))
                expect(config.horizontalSpacing).to(equal(horizontalSpacing))
                expect(config.verticalSpacing).to(equal(verticalSpacing))
            }
            
            it("has valid cases") {
                validate(.standardLargePadLandscape, 40, 6, 10, 6)
                validate(.standardLargePadPortrait, 40, 5, 10, 6)
                validate(.standardPadLandscape, 40, 5, 10, 6)
                validate(.standardPadPortrait, 40, 3, 10, 6)
                validate(.standardPhoneLandscape, 40, 3, 10, 6)
                validate(.standardPhonePortrait, 40, 5, 10, 6)
            }
        }
    }
}

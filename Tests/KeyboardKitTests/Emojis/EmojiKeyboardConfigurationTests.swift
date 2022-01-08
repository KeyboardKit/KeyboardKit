//
//  EmojiKeyboardStyleTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import Quick
import Nimble
import KeyboardKit

class EmojiKeyboardStyleTests: QuickSpec {
    
    override func spec() {
        
        describe("standard configuration list") {
            
            func validate(_ config: EmojiKeyboardStyle, _ itemSize: CGFloat, _ rows: Int, _ horizontalSpacing: CGFloat, _ verticalSpacing: CGFloat) {
                expect(config.itemSize).to(equal(itemSize))
                expect(config.rows).to(equal(rows))
                expect(config.horizontalItemSpacing).to(equal(horizontalSpacing))
                expect(config.verticalItemSpacing).to(equal(verticalSpacing))
            }
            
            it("has valid cases") {
                validate(.standardLargePadLandscape, 60, 6, 15, 10)
                validate(.standardLargePadPortrait, 60, 5, 10, 7)
                validate(.standardPadLandscape, 60, 5, 15, 10)
                validate(.standardPadPortrait, 80, 3, 15, 10)
                validate(.standardPhoneLandscape, 40, 3, 10, 6)
                validate(.standardPhonePortrait, 40, 5, 10, 6)
            }
        }
    }
}

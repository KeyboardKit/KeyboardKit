//
//  UIViewAutoresizing+ExtrasTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class UIViewAutoresizing_ExtrasTests: QuickSpec {
    
    override func spec() {
        
        describe("center in parent") {
            
            it("is valid") {
                let mask = UIView.AutoresizingMask.centerInParent
                expect(mask).to(equal([
                    .flexibleTopMargin, .flexibleBottomMargin,
                    .flexibleLeftMargin, .flexibleRightMargin
                    ]
                ))   
            }
        }
    }
}

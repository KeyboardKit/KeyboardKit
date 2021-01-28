//
//  UIKeyboardToastAlertTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2018-02-25.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class UIKeyboardToastAlertTests: QuickSpec {
    
    override func spec() {
        
        describe("appearance") {
            
            it("uses standard appearance by default") {
                let alerter = UIKeyboardToastAlert()
                expect(alerter.appearance.backgroundColor).to(equal(.white))
                expect(alerter.appearance.cornerRadius).to(equal(10))
                expect(alerter.appearance.font).to(equal(.systemFont(ofSize: 10)))
                expect(alerter.appearance.horizontalPadding).to(equal(20))
                expect(alerter.appearance.textColor).to(equal(.black))
                expect(alerter.appearance.verticalOffset).to(equal(0))
                expect(alerter.appearance.verticalPadding).to(equal(10))
            }
        }
    }
}

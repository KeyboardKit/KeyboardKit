//
//  ToastAlerterTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2018-02-25.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class ToastAlerterTests: QuickSpec {
    
    override func spec() {
        
        describe("appearance") {
            
            let cornerRadius: CGFloat = 12.3
            let font: UIFont = UIFont.systemFont(ofSize: 300)
            let horizontalPadding: CGFloat = 23.4
            let textColor: UIColor = .purple
            let verticalOffset: CGFloat = 34.5
            let verticalPadding: CGFloat = 45.6
            
            var alerter: ToastAlerter!
            
            beforeEach {
                let appearance = ToastAppearance()
                appearance.cornerRadius = cornerRadius
                appearance.font = font
                appearance.horizontalPadding = horizontalPadding
                appearance.textColor = textColor
                appearance.verticalOffset = verticalOffset
                appearance.verticalPadding = verticalPadding
                alerter = ToastAlerter()
                alerter.appearance = appearance
            }
            
            it("applies global style") {
                expect(alerter.appearance.cornerRadius).to(equal(cornerRadius))
                expect(alerter.appearance.font).to(equal(font))
                expect(alerter.appearance.horizontalPadding).to(equal(horizontalPadding))
                expect(alerter.appearance.textColor).to(equal(textColor))
                expect(alerter.appearance.verticalOffset).to(equal(verticalOffset))
                expect(alerter.appearance.verticalPadding).to(equal(verticalPadding))
            }
        }
    }
}

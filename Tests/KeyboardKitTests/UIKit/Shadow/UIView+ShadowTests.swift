//
//  UIView+ShadowTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import UIKit

class UIView_ShadowTests: QuickSpec {
    
    override func spec() {
        
        describe("applying shadow") {
            
            it("applies shadow properties") {
                let view = UIView()
                let shadow = UIShadow.test()
                let layer = view.layer
                view.applyShadow(shadow)
                expect(layer.shadowColor).to(equal(shadow.color.cgColor))
                expect(layer.shadowOpacity).to(equal(shadow.alpha))
                expect(layer.shadowOffset.width).to(equal(0))
                expect(layer.shadowOffset.height).to(equal(0))
                expect(layer.shadowRadius).to(equal(shadow.blur/2))
            }
            
            it("applies behavior properties") {
                let view = UIView()
                let shadow = UIShadow.test()
                let layer = view.layer
                view.applyShadow(shadow)
                expect(layer.shouldRasterize).to(beTrue())
                expect(layer.rasterizationScale).to(equal(UIScreen.main.scale))
            }
            
            it("does not apply shadow path if spread is zero") {
                let view = UIView()
                let shadow = UIShadow.test(spread: 0)
                let layer = view.layer
                view.applyShadow(shadow)
                expect(layer.shadowPath).toNot(beNil())
            }
            
            it("applies shadow path if spread is not zero") {
                let view = UIView()
                let shadow = UIShadow.test(spread: 0.5)
                let layer = view.layer
                view.applyShadow(shadow)
                expect(layer.shadowPath).toNot(beNil())
            }
        }
    }
}

private extension UIShadow {
    
    static func test(spread: CGFloat = 0.8) -> UIShadow {
        return UIShadow(
            alpha: 0.75,
            blur: 0.123,
            color: .red,
            spread: spread,
            x: 100.1,
            y: 200.2)
    }
}

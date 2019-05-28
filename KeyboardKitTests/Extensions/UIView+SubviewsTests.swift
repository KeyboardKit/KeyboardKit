//
//  UIView+SubviewsTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
@testable import KeyboardKit

class UIView_SubviewsTests: QuickSpec {
    
    override func spec() {
        
        describe("adding subview without fill") {
            
            it("just adds subview") {
                let view = UIView()
                let subview = UIView()
                view.addSubview(subview, fill: false)
                expect(view.subviews[0]).to(be(subview))
                expect(subview.superview).to(be(view))
            }
        }
        
        describe("adding subview to fill") {
            
            it("adds subview and activates anchors (which I don't know how to test)") {
                let view = UIView()
                let subview = UIView()
                view.addSubview(subview, fill: true)
                expect(view.subviews[0]).to(be(subview))
                expect(subview.superview).to(be(view))
            }
        }
    }
}

//
//  KeyboardToolbarTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class KeyboardToolbarTests: QuickSpec {
    
    override func spec() {
        
        var view: KeyboardToolbar!
        
        beforeEach {
            view = KeyboardToolbar(height: 123)
        }
        
        describe("created instance") {
            
            it("is correctly configured") {
                expect(view.height).to(equal(123))
                expect(view.heightConstraint?.constant).to(equal(123))
                expect(view.frame).to(equal(.zero))
                expect(view.stackView.alignment).to(equal(.fill))
                expect(view.stackView.distribution).to(equal(.fillEqually))
                expect(view.stackView.axis).to(equal(.horizontal))
                expect(view.subviews.count).to(equal(1))
                expect(view.subviews[0]).to(be(view.stackView))
            }
            
            it("can use custom stackview config") {
                view = KeyboardToolbar(height: 123, alignment: .center, distribution: .equalCentering)
                expect(view.stackView.alignment).to(equal(.center))
                expect(view.stackView.distribution).to(equal(.equalCentering))
            }
        }
    }
}

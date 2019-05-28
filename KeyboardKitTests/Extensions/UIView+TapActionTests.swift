//
//  UIView+TapActionTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class UIView_TapActionTests: QuickSpec {
    
    override func spec() {
        
        describe("adding tap action") {
            
            it("adds tap gesture recognizer") {
                let view = UIView(frame: .zero)
                expect(view.gestureRecognizers).to(beNil())
                view.addTapAction {}
                expect(view.gestureRecognizers?.count).to(equal(1))
                expect(view.gestureRecognizers?[0] as? UITapGestureRecognizer).toNot(beNil())
            }
        }
        
        describe("removing tap action") {
            
            it("removes correct gesture recognizer") {
                let view = UIView(frame: .zero)
                view.addLongPressAction {}
                view.addTapAction {}
                expect(view.gestureRecognizers?.count).to(equal(2))
                view.removeTapAction()
                expect(view.gestureRecognizers?.count).to(equal(1))
                expect(view.gestureRecognizers?[0] as? UILongPressGestureRecognizer).toNot(beNil())
            }
        }
    }
}

//
//  UIView+LongPressActionTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class UIView_LongPressActionTests: QuickSpec {
    
    override func spec() {
        
        describe("adding long press action") {
            
            it("adds long press gesture recognizer") {
                let view = UIView(frame: .zero)
                expect(view.gestureRecognizers).to(beNil())
                view.addLongPressAction {}
                expect(view.gestureRecognizers?.count).to(equal(1))
                expect(view.gestureRecognizers?[0] as? UILongPressGestureRecognizer).toNot(beNil())
            }
        }
        
        describe("removing long press action") {
            
            it("removes correct gesture recognizer") {
                let view = UIView(frame: .zero)
                view.addTapAction {}
                view.addLongPressAction {}
                expect(view.gestureRecognizers?.count).to(equal(2))
                view.removeLongPressAction()
                expect(view.gestureRecognizers?.count).to(equal(1))
                expect(view.gestureRecognizers?[0] as? UITapGestureRecognizer).toNot(beNil())
            }
        }
    }
}

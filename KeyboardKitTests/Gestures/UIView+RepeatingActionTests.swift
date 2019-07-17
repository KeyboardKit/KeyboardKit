//
//  UIView+RepeatingActionTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-31.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class UIView_RepeatingActionTests: QuickSpec {
    
    override func spec() {
        
        describe("adding action") {
            
            it("adds correct gesture recognizer") {
                let view = UIView(frame: .zero)
                expect(view.gestureRecognizers).to(beNil())
                view.addRepeatingAction {}
                expect(view.gestureRecognizers?.count).to(equal(1))
                expect(view.gestureRecognizers?[0] as? RepeatingGestureRecognizer).toNot(beNil())
            }
        }
        
        describe("removing action") {
            
            it("removes correct gesture recognizer") {
                let view = UIView(frame: .zero)
                view.addLongPressAction {}
                view.addRepeatingAction {}
                expect(view.gestureRecognizers?.count).to(equal(2))
                view.removeRepeatingAction()
                expect(view.gestureRecognizers?.count).to(equal(1))
                expect(view.gestureRecognizers?[0] as? UILongPressGestureRecognizer).toNot(beNil())
            }
        }
    }
}

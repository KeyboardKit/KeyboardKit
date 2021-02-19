//
//  UIKeyboardButton+GesturesTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-28.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import MockingKit
import UIKit

class UIKeyboardButton_GesturesTests: QuickSpec {
    
    override func spec() {
        
        var vc: MockKeyboardInputViewController!
        
        beforeEach {
            vc = MockKeyboardInputViewController(nibName: nil, bundle: nil)
        }
        
        describe("adding keyboard gestures to button") {
            
            var button: TestButton!
            
            beforeEach {
                button = TestButton(type: .custom)
            }
            
            it("removes already added gestures") {
                button.addKeyboardGestures(in: vc)
                let oldTap = button.gestureRecognizers!.first { $0 is UITapGestureRecognizer }
                let oldPress = button.gestureRecognizers!.first { $0 is UILongPressGestureRecognizer }
                let oldRepeat = button.gestureRecognizers!.first { $0 is UIRepeatingGestureRecognizer }
                button.addKeyboardGestures(in: vc)
                let newTap = button.gestureRecognizers!.first { $0 is UITapGestureRecognizer }
                let newPress = button.gestureRecognizers!.first { $0 is UILongPressGestureRecognizer }
                let newRepeat = button.gestureRecognizers!.first { $0 is UIRepeatingGestureRecognizer }
                expect(newTap).toNot(be(oldTap))
                expect(newPress).toNot(be(oldPress))
                expect(newRepeat).toNot(be(oldRepeat))
            }
            
            it("handles next keyboard separately") {
                button.action = .nextKeyboard
                button.addKeyboardGestures(in: vc)
                let tap = button.gestureRecognizers?.first { $0 is UITapGestureRecognizer }
                let press = button.gestureRecognizers?.first { $0 is UILongPressGestureRecognizer }
                let repeating = button.gestureRecognizers?.first { $0 is UIRepeatingGestureRecognizer }
                expect(tap).to(beNil())
                expect(press).to(beNil())
                expect(repeating).to(beNil())
            }
            
            it("adds gestures to button") {
                button.addKeyboardGestures(in: vc)
                let tap = button.gestureRecognizers!.first { $0 is UITapGestureRecognizer }
                let press = button.gestureRecognizers!.first { $0 is UILongPressGestureRecognizer }
                let repeating = button.gestureRecognizers!.first { $0 is UIRepeatingGestureRecognizer }
                expect(tap).toNot(beNil())
                expect(press).toNot(beNil())
                expect(repeating).toNot(beNil())
            }
        }
    }
}

private class TestButton: UIButton, UIKeyboardButton {
    var action: KeyboardAction = .backspace
    var secondaryAction: KeyboardAction? = KeyboardAction.none
    var widthConstraint: NSLayoutConstraint?
}

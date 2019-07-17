//
//  KeyboardInputViewControllerTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import MockNRoll

class KeyboardInputViewControllerTests: QuickSpec {
    
    override func spec() {
        
        var viewController: TestClass!
        
        beforeEach {
            viewController = TestClass(nibName: nil, bundle: nil)
        }
        
        describe("view did load") {
            
            it("adds keyboard stack view to vc view") {
                let view = viewController.view
                viewController.viewDidLoad()
                expect(view?.subviews.count).to(equal(3))
                expect(view?.subviews[2]).to(be(viewController.keyboardStackView))
            }
        }
        
        describe("view will appear") {
            
            it("syncs with text document proxy") {
                viewController.viewWillAppear(false)
                let exec = viewController.recorder.executions(of: viewController.viewWillSyncWithTextDocumentProxy)
                expect(exec.count).to(equal(1))
            }
        }
        
        describe("action handler") {
            
            it("is standard handler by default") {
                let handler = viewController.keyboardActionHandler
                let standard = handler as? StandardKeyboardActionHandler
                expect(standard).toNot(beNil())
                expect(standard?.inputViewController).to(be(viewController))
            }
        }
        
        describe("keyboard stack view") {
            
            it("is correctly configured") {
                let view = viewController.keyboardStackView
                expect(view.axis).to(equal(.vertical))
                expect(view.alignment).to(equal(.fill))
                expect(view.distribution).to(equal(.equalSpacing))
            }
        }
        
        describe("adding keyboard gestures to button") {
            
            var button: TestButton!
            
            beforeEach {
                button = TestButton(type: .custom)
            }
            
            it("removes already added gestures") {
                button.addTapAction {}
                button.addLongPressAction {}
                button.addRepeatingAction {}
                let oldTap = button.gestureRecognizers!.first { $0 is UITapGestureRecognizer }
                let oldPress = button.gestureRecognizers!.first { $0 is UILongPressGestureRecognizer }
                let oldRepeat = button.gestureRecognizers!.first { $0 is RepeatingGestureRecognizer }
                viewController.addKeyboardGestures(to: button)
                let newTap = button.gestureRecognizers!.first { $0 is UITapGestureRecognizer }
                let newPress = button.gestureRecognizers!.first { $0 is UILongPressGestureRecognizer }
                let newRepeat = button.gestureRecognizers!.first { $0 is RepeatingGestureRecognizer }
                expect(newTap).toNot(be(oldTap))
                expect(newPress).toNot(be(oldPress))
                expect(newRepeat).toNot(be(oldRepeat))
            }
            
            it("handles switch keyboard separately") {
                button.action = .switchKeyboard
                viewController.addKeyboardGestures(to: button)
                let tap = button.gestureRecognizers?.first { $0 is UITapGestureRecognizer }
                let press = button.gestureRecognizers?.first { $0 is UILongPressGestureRecognizer }
                let repeating = button.gestureRecognizers?.first { $0 is RepeatingGestureRecognizer }
                expect(tap).to(beNil())
                expect(press).to(beNil())
                expect(repeating).to(beNil())
            }
            
            it("adds gestures to button") {
                viewController.addKeyboardGestures(to: button)
                let tap = button.gestureRecognizers!.first { $0 is UITapGestureRecognizer }
                let press = button.gestureRecognizers!.first { $0 is UILongPressGestureRecognizer }
                let repeating = button.gestureRecognizers!.first { $0 is RepeatingGestureRecognizer }
                expect(tap).toNot(beNil())
                expect(press).toNot(beNil())
                expect(repeating).toNot(beNil())
            }
        }
    }
}

private class TestClass: KeyboardInputViewController {
    
    var recorder = Mock()
    
    override func viewWillSyncWithTextDocumentProxy() {
        recorder.invoke(viewWillSyncWithTextDocumentProxy, args: ())
    }
}

private class TestButton: UIButton, KeyboardButton {
    var action: KeyboardAction = .backspace
    var secondaryAction: KeyboardAction? = KeyboardAction.none
    var widthConstraint: NSLayoutConstraint?
}

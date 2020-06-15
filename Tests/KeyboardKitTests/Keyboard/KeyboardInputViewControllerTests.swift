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
import Mockery
import UIKit

class KeyboardInputViewControllerTests: QuickSpec {
    
    override func spec() {
        
        var viewController: TestClass!
        
        beforeEach {
            viewController = TestClass(nibName: nil, bundle: nil)
        }
        
        describe("view will appear") {
            
            it("syncs with text document proxy") {
                viewController.viewWillAppear(false)
                let exec = viewController.recorder.invokations(of: viewController.viewWillSyncWithTextDocumentProxy)
                expect(exec.count).to(equal(1))
            }
        }
        
        describe("view will layout subviews") {
            
            it("updates context") {
                viewController.needsInputModeSwitchKeyValue = true
                viewController.viewWillLayoutSubviews()
                expect(viewController.context.needsInputModeSwitchKey).to(beTrue())
                viewController.needsInputModeSwitchKeyValue = false
                viewController.viewWillLayoutSubviews()
                expect(viewController.context.needsInputModeSwitchKey).to(beFalse())
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
            
            it("is not added to vc view if not referred") {
                let view = viewController.view
                viewController.viewDidLoad()
                expect(view?.subviews.count).to(equal(2))
            }
            
            it("is added to vc view when it's first referred") {
                let view = viewController.view
                _ = viewController.keyboardStackView
                expect(view?.subviews.count).to(equal(3))
                expect(view?.subviews[2]).to(be(viewController.keyboardStackView))
            }
            
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
                viewController.addKeyboardGestures(to: button)
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
            
            it("handles next keyboard separately") {
                button.action = .nextKeyboard
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
    
    var needsInputModeSwitchKeyValue = false
    override var needsInputModeSwitchKey: Bool { needsInputModeSwitchKeyValue }
    
    override func viewWillSyncWithTextDocumentProxy() {
        recorder.invoke(viewWillSyncWithTextDocumentProxy, args: ())
    }
}

private class TestButton: UIButton, KeyboardButton {
    var action: KeyboardAction = .backspace
    var secondaryAction: KeyboardAction? = KeyboardAction.none
    var widthConstraint: NSLayoutConstraint?
}

//
//  KeyboardButtonViewTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class KeyboardButtonViewTests: QuickSpec {
    
    override func spec() {
        
        var view: KeyboardButtonView!
        
        beforeEach {
            view = KeyboardButtonView(type: .custom)
        }
        
        describe("created instance") {
            
            it("has correct property values") {
                expect(view.action).to(equal(KeyboardAction.none))
                expect(view.secondaryAction).to(beNil())
                expect(view.keyboardAppearance).to(equal(.default))
            }
        }
        
        describe("intrinsic content size") {
            
            it("uses width constraint") {
                view.width = 123
                let width = view.intrinsicContentSize.width
                expect(width).to(equal(123))
            }
        }
        
        describe("setting up view") {
            
            it("sets view properties") {
                view.setup(with: .backspace, secondaryAction: .dismissKeyboard, in: KeyboardInputViewController())
                expect(view.action).to(equal(.backspace))
                expect(view.secondaryAction).to(equal(.dismissKeyboard))
                expect(view.keyboardAppearance).to(equal(.default))
            }
            
            it("adds keyboard gestures to view") {
                let viewController = MockKeyboardInputViewController()
                view.setup(with: .backspace, secondaryAction: .dismissKeyboard, in: viewController)
                let exec = viewController.recorder.invokations(of: viewController.addKeyboardGestures)
                expect(exec.count).to(equal(1))
                expect(exec[0].arguments).to(be(view))
            }
        }
    }
}

//
//  KeyboardInputViewControllerTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import MockingKit
import UIKit

class KeyboardInputViewControllerTests: QuickSpec {
    
    override func spec() {
        
        var vc: TestClass!
        
        beforeEach {
            vc = TestClass(nibName: nil, bundle: nil)
        }
        
        describe("keyboard context") {
            
            it("is setup with default state") {
                let context = vc.keyboardContext
                expect(context.actionHandler is StandardKeyboardActionHandler).to(beTrue())
                expect(context.hasFullAccess).to(beFalse())
                expect(context.keyboardType).to(equal(.alphabetic(.lowercased)))
                expect(context.needsInputModeSwitchKey).to(beFalse())
            }
        }
        
        describe("view did load") {
            
            it("sets up the keyboard") {
                expect(vc.hasInvoked(vc.setupKeyboardRef)).to(beFalse())
                vc.viewDidLoad()
                expect(vc.hasInvoked(vc.setupKeyboardRef)).to(beTrue())
            }
        }
        
        describe("view will appear") {
            
            it("updates context") {
                vc.hasFullAccessValue = true
                vc.viewWillAppear(false)
                expect(vc.keyboardContext.hasFullAccess).to(beTrue())
                vc.hasFullAccessValue = false
                vc.viewWillAppear(false)
                expect(vc.keyboardContext.hasFullAccess).to(beFalse())
            }
            
            it("syncs with text document proxy") {
                expect(vc.hasInvoked(vc.viewWillSyncWithTextDocumentProxyRef)).to(beFalse())
                vc.viewWillAppear(false)
                expect(vc.hasInvoked(vc.viewWillSyncWithTextDocumentProxyRef)).to(beTrue())
            }
        }
        
        describe("view will layout subviews") {
            
            it("updates context") {
                vc.hasDictationKeyValue = true
                vc.needsInputModeSwitchKeyValue = true
                vc.viewWillLayoutSubviews()
                expect(vc.keyboardContext.hasDictationKey).to(beTrue())
                expect(vc.keyboardContext.needsInputModeSwitchKey).to(beTrue())
                vc.hasDictationKeyValue = false
                vc.needsInputModeSwitchKeyValue = false
                vc.viewWillLayoutSubviews()
                expect(vc.keyboardContext.hasDictationKey).to(beFalse())
                expect(vc.keyboardContext.needsInputModeSwitchKey).to(beFalse())
            }
        }
        
        describe("view will sync with text document proxy") {
            
            it("updates context") {
                expect(vc.keyboardContext.textDocumentProxy).to(be(vc.textDocumentProxy))
                vc.keyboardContext.textDocumentProxy = UIInputViewController().textDocumentProxy
                expect(vc.keyboardContext.textDocumentProxy).toNot(be(vc.textDocumentProxy))
                vc.viewWillSyncWithTextDocumentProxy()
                expect(vc.keyboardContext.textDocumentProxy).to(be(vc.textDocumentProxy))
            }
        }
        
        describe("keyboard action handler") {
            
            it("is standard handler by default") {
                let handler = vc.keyboardActionHandler
                let standard = handler as? StandardKeyboardActionHandler
                expect(standard).toNot(beNil())
            }
        }
        
        describe("keyboard appearance provider") {
            
            it("is standard behavior by default") {
                let handler = vc.keyboardAppearance
                let standard = handler as? StandardKeyboardAppearance
                expect(standard).toNot(beNil())
            }
        }
        
        describe("keyboard behavior") {
            
            it("is standard behavior by default") {
                let handler = vc.keyboardBehavior
                let standard = handler as? StandardKeyboardBehavior
                expect(standard).toNot(beNil())
            }
        }
        
        describe("keyboard stack view") {
            
            it("is not added to vc view if not referred") {
                let view = vc.view
                vc.viewDidLoad()
                expect(view?.subviews.count).to(equal(2))
            }
            
            it("is added to vc view when it's first referred") {
                let view = vc.view
                _ = vc.keyboardStackView
                expect(view?.subviews.count).to(equal(3))
                expect(view?.subviews[2]).to(be(vc.keyboardStackView))
            }
            
            it("is correctly configured") {
                let view = vc.keyboardStackView
                expect(view.axis).to(equal(.vertical))
                expect(view.alignment).to(equal(.fill))
                expect(view.distribution).to(equal(.equalSpacing))
            }
        }
        
        describe("perform autocomplete") {
            
            it("is triggered by textDidChange") {
                expect(vc.hasInvoked(vc.performAutocompleteRef)).to(beFalse())
                vc.textDidChange(nil)
                expect(vc.hasInvoked(vc.performAutocompleteRef)).to(beTrue())
            }
        }
        
        describe("reset autocomplete") {
            
            it("is triggered by selectionWillChange") {
                expect(vc.hasInvoked(vc.resetAutocompleteRef)).to(beFalse())
                vc.selectionWillChange(nil)
                expect(vc.hasInvoked(vc.resetAutocompleteRef)).to(beTrue())
            }
        }
        
        describe("reset autocomplete") {
            
            it("is triggered by selectionWillChange") {
                expect(vc.hasInvoked(vc.resetAutocompleteRef)).to(beFalse())
                vc.selectionDidChange(nil)
                expect(vc.hasInvoked(vc.resetAutocompleteRef)).to(beTrue())
            }
        }
        
        describe("text will change") {
            
            it("calls viewWillSyncWithTextDocumentProxy") {
                vc.textWillChange(nil)
                expect(vc.keyboardContext.textDocumentProxy).to(be(vc.textDocumentProxy))
            }
        }
    }
}

private class TestClass: KeyboardInputViewController, Mockable {
    
    lazy var viewWillSyncWithTextDocumentProxyRef = MockReference(viewWillSyncWithTextDocumentProxy)
    lazy var setupKeyboardRef = MockReference(setupKeyboard)
    lazy var performAutocompleteRef = MockReference(performAutocomplete)
    lazy var resetAutocompleteRef = MockReference(resetAutocomplete)
    
    let mock = Mock()
    
    var hasFullAccessValue = false
    override var hasFullAccess: Bool { hasFullAccessValue }
    
    var hasDictationKeyValue = false
    override var hasDictationKey: Bool {
        get { hasDictationKeyValue }
        set { hasDictationKeyValue = newValue }
    }
    
    var needsInputModeSwitchKeyValue = false
    override var needsInputModeSwitchKey: Bool { needsInputModeSwitchKeyValue }
    
    override func viewWillSyncWithTextDocumentProxy() {
        super.viewWillSyncWithTextDocumentProxy()
        mock.invoke(viewWillSyncWithTextDocumentProxyRef, args: ())
    }
    
    override func setupKeyboard() {
        mock.invoke(setupKeyboardRef, args: ())
    }
    
    override func performAutocomplete() {
        mock.invoke(performAutocompleteRef, args: ())
    }
    
    override func resetAutocomplete() {
        mock.invoke(resetAutocompleteRef, args: ())
    }
}

private class TestButton: UIButton, UIKeyboardButton {
    var action: KeyboardAction = .backspace
    var secondaryAction: KeyboardAction? = KeyboardAction.none
    var widthConstraint: NSLayoutConstraint?
}

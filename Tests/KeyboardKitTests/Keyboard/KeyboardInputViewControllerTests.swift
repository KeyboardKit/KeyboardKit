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
        
        func expectSyncedContext(for function: () -> Void) {
            vc.hasFullAccessValue = true
            function()
            expect(vc.keyboardContext.hasFullAccess).to(beTrue())
            vc.hasFullAccessValue = false
            function()
            expect(vc.keyboardContext.hasFullAccess).to(beFalse())
            expect(vc.keyboardContext.textDocumentProxy).to(be(vc.textDocumentProxy))
        }
        
        beforeEach {
            TestClass.shared = nil
            vc = TestClass(nibName: nil, bundle: nil)
        }
        
        describe("keyboard context") {
            
            it("is setup with default state") {
                let context = vc.keyboardContext
                expect(context.hasFullAccess).to(beFalse())
                expect(context.keyboardType).to(equal(.alphabetic(.lowercased)))
                expect(context.needsInputModeSwitchKey).to(beFalse())
            }
        }
        
        describe("view did load") {
            
            it("sets vc as shared") {
                expect(TestClass.shared).to(beNil())
                vc.viewDidLoad()
                expect(TestClass.shared).toNot(beNil())
            }
        }
        
        describe("view will appear") {
            
            it("updates context") {
                expectSyncedContext { vc.viewWillAppear(false) }
            }
        }
        
        describe("view will layout subviews") {
            
            it("updates context") {
                expectSyncedContext(for: vc.viewWillLayoutSubviews)
            }
        }
        
        describe("view trait collection did change") {
            
            it("updates context") {
                expectSyncedContext {
                    vc.traitCollectionDidChange(.none)
                }
            }
        }
        
        describe("keyboard action handler") {
            
            it("is standard by default") {
                let obj = vc.keyboardActionHandler
                expect(obj as? StandardKeyboardActionHandler).toNot(beNil())
            }
        }
        
        describe("keyboard appearance provider") {
            
            it("is standard by default") {
                let obj = vc.keyboardAppearance
                expect(obj as? StandardKeyboardAppearance).toNot(beNil())
            }
        }
        
        describe("keyboard behavior") {
            
            it("is standard by default") {
                let obj = vc.keyboardBehavior
                expect(obj as? StandardKeyboardBehavior).toNot(beNil())
            }
        }
        
        describe("keyboard context") {
            
            it("is observable to self by default") {
                let context = vc.keyboardContext
                expect(context.textDocumentProxy).to(be(vc.textDocumentProxy))
            }
        }
        
        describe("keyboard input callout context") {
            
            it("is correctly setup") {
                let context = vc.keyboardInputCalloutContext
                expect(context).to(be(context))
            }
        }
        
        describe("keyboard input set provider") {
            
            it("is standard by default") {
                let obj = vc.keyboardInputSetProvider
                expect(obj as? StandardKeyboardInputSetProvider).toNot(beNil())
            }
        }
        
        describe("keyboard layout provider") {
            
            it("is standard by default") {
                let obj = vc.keyboardLayoutProvider
                expect(obj as? StandardKeyboardLayoutProvider).toNot(beNil())
            }
        }
        
        describe("keyboard secondary input action provider") {
            
            it("is standard by default") {
                let obj = vc.keyboardSecondaryInputActionProvider
                expect(obj as? StandardSecondaryCalloutActionProvider).toNot(beNil())
            }
        }
        
        describe("keyboard secondary input callout context") {
            
            it("is correctly setup") {
                let context = vc.keyboardSecondaryInputCalloutContext
                expect(context).to(be(context))
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
    
    var hasDictationKeyValue = false
    var hasFullAccessValue = false
    
    override var hasFullAccess: Bool { hasFullAccessValue }
    
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

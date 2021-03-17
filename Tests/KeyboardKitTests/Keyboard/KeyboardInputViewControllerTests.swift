//
//  KeyboardInputViewControllerTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import MockingKit
import SwiftUI
import UIKit
@testable import KeyboardKit

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
        
        
        // MARK: - View Controller Lifecycle
        
        describe("view did load") {
            
            it("sets vc as shared") {
                expect(TestClass.shared).to(beNil())
                vc.viewDidLoad()
                expect(TestClass.shared).toNot(beNil())
            }
            
            it("sets up context observations") {
                vc.viewDidLoad()
                expect(vc.cancellables.count).to(beGreaterThan(0))
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
        
        
        // MARK: - Setup
        
        describe("setting up with view") {
            
            it("registers a hosting controller") {
                expect(vc.children.count).to(equal(0))
                vc.setup(with: Text("HEJ"))
                expect(vc.children.count).to(equal(1))
                expect(vc.view.subviews.count).to(equal(1))
            }
        }
        
        
        // MARK: - Properties
        
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
            
            it("is setup with default state") {
                let context = vc.keyboardContext
                expect(context.hasFullAccess).to(beFalse())
                expect(context.keyboardType).to(equal(.alphabetic(.lowercased)))
                expect(context.needsInputModeSwitchKey).to(beFalse())
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
            
            it("is registered into the layout provider when changed") {
                let newProvider = MockKeyboardInputSetProvider()
                vc.keyboardInputSetProvider = newProvider
                let layoutProvider = vc.keyboardLayoutProvider as? StandardKeyboardLayoutProvider
                expect(layoutProvider?.inputSetProvider).to(be(newProvider))
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
                let obj = vc.keyboardSecondaryCalloutActionProvider
                expect(obj as? StandardSecondaryCalloutActionProvider).toNot(beNil())
            }
        }
        
        describe("keyboard secondary input callout context") {
            
            it("is correctly setup") {
                let context = vc.keyboardSecondaryInputCalloutContext
                expect(context).to(be(context))
            }
        }
        
        
        // MARK: - View Properties
        
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
        
        // MARK: - Text And Selection Change
        
        describe("selectionWillChange") {
            
            it("triggers resetAutocomplete") {
                expect(vc.hasCalled(vc.resetAutocompleteRef)).to(beFalse())
                vc.selectionWillChange(nil)
                expect(vc.hasCalled(vc.resetAutocompleteRef)).to(beTrue())
            }
        }
        
        describe("selectionDidChange") {
            
            it("triggers resetAutocomplete") {
                expect(vc.hasCalled(vc.resetAutocompleteRef)).to(beFalse())
                vc.selectionDidChange(nil)
                expect(vc.hasCalled(vc.resetAutocompleteRef)).to(beTrue())
            }
        }
        
        describe("textWillChange") {
            
            it("triggers viewWillSyncWithTextDocumentProxy") {
                vc.textWillChange(nil)
                expect(vc.keyboardContext.textDocumentProxy).to(be(vc.textDocumentProxy))
            }
        }
        
        describe("textDidChange") {
            
            it("triggers performAutocomplete") {
                expect(vc.hasCalled(vc.performAutocompleteRef)).to(beFalse())
                vc.textDidChange(nil)
                expect(vc.hasCalled(vc.performAutocompleteRef)).to(beTrue())
            }

            it("tries to change keyboard type") {
                vc.keyboardContext.keyboardType = .alphabetic(.lowercased)
                vc.textDidChange(nil)
                vc.keyboardContext.keyboardType = .alphabetic(.uppercased)
            }
        }
        
        
        // MARK: - Observation
        
        describe("changing keyboard locale") {
            
            it("replaces locale of all locale-based dependencies") {
                let locale = KeyboardLocale.swedish
                vc.viewDidLoad()
                vc.keyboardContext.locale = locale.locale
                expect(vc.autocompleteSuggestionProvider.locale).toEventually(equal(locale.locale))
            }
        }
        
        
        // MARK: - Public Functions
        
        describe("performing autocomplete") {
            
            var provider: MockAutocompleteSuggestionProvider!
            var proxy: MockTextDocumentProxy!
            
            beforeEach {
                provider = MockAutocompleteSuggestionProvider()
                proxy = MockTextDocumentProxy()
                vc.autocompleteSuggestionProvider = provider
                vc.textDocumentProxyValue = proxy
            }
            
            it("aborts if text proxy has no current word") {
                provider.autocompleteSuggestionsResult = .success([StandardAutocompleteSuggestion("")])
                vc.performAutocomplete()
                expect(vc.autocompleteContext.suggestions.count).toEventually(equal(0))
            }
            
            it("writes result to autocomplete context") {
                provider.autocompleteSuggestionsResult = .success([StandardAutocompleteSuggestion("")])
                proxy.documentContextBeforeInput = "foo bar"
                vc.performAutocomplete()
                expect(vc.autocompleteContext.suggestions.count).toEventually(equal(1))
            }
        }
        
        describe("resetting autocomplete") {
            
            it("writes result to autocomplete context") {
                vc.autocompleteContext.suggestions = [StandardAutocompleteSuggestion("")]
                vc.resetAutocomplete()
                expect(vc.autocompleteContext.suggestions.count).to(equal(0))
            }
        }
    }
}

private class TestClass: KeyboardInputViewController, Mockable {
    
    lazy var viewWillSyncWithTextDocumentProxyRef = MockReference(viewWillSyncWithTextDocumentProxy)
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
    
    var textDocumentProxyValue: UITextDocumentProxy?
    override var textDocumentProxy: UITextDocumentProxy {
        textDocumentProxyValue ?? super.textDocumentProxy
    }
    
    override func viewWillSyncWithTextDocumentProxy() {
        super.viewWillSyncWithTextDocumentProxy()
        mock.call(viewWillSyncWithTextDocumentProxyRef, args: ())
    }
    
    override func performAutocomplete() {
        mock.call(performAutocompleteRef, args: ())
        super.performAutocomplete()
    }
    
    override func resetAutocomplete() {
        mock.call(resetAutocompleteRef, args: ())
        super.resetAutocomplete()
    }
}

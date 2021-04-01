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
            
            it("creates and adds a keyboard hosting controller") {
                expect(vc.children.count).to(equal(0))
                vc.setup(with: Text("HEJ"))
                expect(vc.children.count).to(equal(1))
                expect(vc.view.subviews.count).to(equal(1))
            }
        }
    
        describe("setting up with stack view") {
            
            it("adds and configures the view") {
                expect(vc.view.subviews.count).to(equal(2))
                let view = UIStackView()
                vc.setup(with: view)
                expect(vc.view.subviews.count).to(equal(1))
                expect(view.frame).to(equal(.zero))
                expect(view.axis).to(equal(.vertical))
                expect(view.alignment).to(equal(.fill))
                expect(view.distribution).to(equal(.equalSpacing))
            }
        }
        
        
        // MARK: - Observables
        
        describe("observable properties") {
            
            it("has standard instances by default") {
                expect(vc.autocompleteContext.suggestions.isEmpty).to(beTrue())
                expect(vc.keyboardContext.hasFullAccess).to(beFalse())
                expect(vc.keyboardContext.keyboardType).to(equal(.alphabetic(.lowercased)))
                expect(vc.keyboardContext.needsInputModeSwitchKey).to(beFalse())
                expect(vc.keyboardContext.textDocumentProxy).to(be(vc.textDocumentProxy))
                expect(vc.keyboardFeedbackSettings.audioConfiguration).to(equal(.standard))
                expect(vc.keyboardFeedbackSettings.hapticConfiguration).to(equal(.standard))
                expect(vc.keyboardInputCalloutContext.buttonFrame).to(equal(.zero))
                expect(vc.keyboardSecondaryInputCalloutContext.buttonFrame).to(equal(.zero))
            }
        }
        
        
        // MARK: - Services
        
        describe("service properties") {
            
            it("has standard instances by default") {
                expect(vc.autocompleteSuggestionProvider as? DisabledAutocompleteSuggestionProvider).toNot(beNil())
                expect(vc.keyboardActionHandler as? StandardKeyboardActionHandler).toNot(beNil())
                expect(vc.keyboardAppearance as? StandardKeyboardAppearance).toNot(beNil())
                expect(vc.keyboardBehavior as? StandardKeyboardBehavior).toNot(beNil())
                expect(vc.keyboardFeedbackHandler as? StandardKeyboardFeedbackHandler).toNot(beNil())
                expect(vc.keyboardInputSetProvider as? StandardKeyboardInputSetProvider).toNot(beNil())
                expect(vc.keyboardLayoutProvider as? StandardKeyboardLayoutProvider).toNot(beNil())
                expect(vc.keyboardSecondaryCalloutActionProvider as? StandardSecondaryCalloutActionProvider).toNot(beNil())
            }
        }
        
        describe("changing keyboard input set provider") {
            
            it("is registered into the layout provider") {
                let newProvider = MockKeyboardInputSetProvider()
                vc.keyboardInputSetProvider = newProvider
                let layoutProvider = vc.keyboardLayoutProvider as? StandardKeyboardLayoutProvider
                expect(layoutProvider?.inputSetProvider).to(be(newProvider))
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
        
        
        // MARK: - Autocomplete
        
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

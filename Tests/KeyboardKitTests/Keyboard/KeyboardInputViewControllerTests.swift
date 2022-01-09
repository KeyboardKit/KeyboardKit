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
            TestClass.shared = TestClass(nibName: nil, bundle: nil)
            vc = TestClass(nibName: nil, bundle: nil)
        }
        
        
        // MARK: - View Controller Lifecycle
        
        describe("view did load") {
            
            it("sets vc as shared") {
                expect(TestClass.shared).toNot(be(vc))
                vc.viewDidLoad()
                expect(TestClass.shared).to(be(vc))
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
        
        
        // MARK: - Properties
        
        describe("text document proxy") {
            
            it("returns the original text document proxy if no input proxy is defined") {
                expect(vc.textDocumentProxy).to(be(vc.originalTextDocumentProxy))
            }
            
            it("returns the input text document proxy if one is defined") {
                let input = MockTextInput()
                let proxy = TextInputProxy(input: input)
                vc.textInputProxy = proxy
                expect(vc.textDocumentProxy).to(be(proxy))
            }
        }
        
        describe("text input proxy") {
            
            it("makes vc sync with proxy when set") {
                vc.mock.resetCalls()
                let input = MockTextInput()
                let proxy = TextInputProxy(input: input)
                vc.textInputProxy = proxy
                expect(vc.keyboardContext.textDocumentProxy).to(be(proxy))
            }
        }
        
        
        
        // MARK: - Observables
        
        describe("observable properties") {
            
            it("has standard instances by default") {
                expect(vc.actionCalloutContext.buttonFrame).to(equal(.zero))
                expect(vc.autocompleteContext.suggestions.isEmpty).to(beTrue())
                expect(vc.inputCalloutContext.buttonFrame).to(equal(.zero))
                expect(vc.keyboardContext.hasFullAccess).to(beFalse())
                expect(vc.keyboardContext.keyboardType).to(equal(.alphabetic(.lowercased)))
                expect(vc.keyboardContext.needsInputModeSwitchKey).to(beFalse())
                expect(vc.keyboardContext.textDocumentProxy).to(be(vc.textDocumentProxy))
                expect(vc.keyboardFeedbackSettings.audioConfiguration).to(equal(.standard))
                expect(vc.keyboardFeedbackSettings.hapticConfiguration).to(equal(.standard))
            }
        }
        
        
        // MARK: - Services
        
        describe("service properties") {
            
            it("has standard instances by default") {
                expect(vc.autocompleteProvider as? DisabledAutocompleteProvider).toNot(beNil())
                expect(vc.calloutActionProvider as? StandardCalloutActionProvider).toNot(beNil())
                expect(vc.inputSetProvider as? StandardInputSetProvider).toNot(beNil())
                expect(vc.keyboardActionHandler as? StandardKeyboardActionHandler).toNot(beNil())
                expect(vc.keyboardAppearance as? StandardKeyboardAppearance).toNot(beNil())
                expect(vc.keyboardBehavior as? StandardKeyboardBehavior).toNot(beNil())
                expect(vc.keyboardFeedbackHandler as? StandardKeyboardFeedbackHandler).toNot(beNil())
                expect(vc.keyboardLayoutProvider as? StandardKeyboardLayoutProvider).toNot(beNil())
            }
        }
        
        describe("refreshing properties when changing service properties") {
            
            func verifyRefresh() {
                let actionContext = vc.actionCalloutContext
                let layoutProvider = vc.keyboardLayoutProvider as? StandardKeyboardLayoutProvider
                expect(layoutProvider?.inputSetProvider).to(be(vc.inputSetProvider))
                expect(actionContext.actionProvider).to(be(vc.calloutActionProvider))
                expect(actionContext.actionHandler).to(be(vc.keyboardActionHandler))
            }
            
            it("is done for keyboard action handler") {
                vc.keyboardActionHandler = MockKeyboardActionHandler()
                verifyRefresh()
            }
            
            it("is done for keyboard input set provider") {
                vc.inputSetProvider = MockInputSetProvider()
                verifyRefresh()
            }
            
            it("is done for callout action provider") {
                vc.calloutActionProvider = StandardCalloutActionProvider(context: .preview)
                verifyRefresh()
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
                expect(vc.autocompleteProvider.locale).toEventually(equal(locale.locale))
            }
        }
        
        
        // MARK: - Autocomplete
        
        describe("performing autocomplete") {
            
            var provider: MockAutocompleteProvider!
            var proxy: MockTextDocumentProxy!
            
            beforeEach {
                provider = MockAutocompleteProvider()
                proxy = MockTextDocumentProxy()
                vc.autocompleteProvider = provider
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
    
    override func performAutocomplete() {
        mock.call(performAutocompleteRef, args: ())
        super.performAutocomplete()
    }
    
    override func resetAutocomplete() {
        mock.call(resetAutocompleteRef, args: ())
        super.resetAutocomplete()
    }
}

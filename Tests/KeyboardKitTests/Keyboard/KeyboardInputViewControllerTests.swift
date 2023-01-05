//
//  KeyboardInputViewControllerTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import MockingKit
import SwiftUI
import UIKit
import XCTest

@testable import KeyboardKit

class KeyboardInputViewControllerTests: XCTestCase {
    
    private var vc: TestClass!

    private let mockAutocompleteProvider = MockAutocompleteProvider()
    private let mockTextDocumentProxy = MockTextDocumentProxy()

    override func setUp() {
        TestClass.shared = TestClass(nibName: nil, bundle: nil)
        vc = TestClass(nibName: nil, bundle: nil)
    }

    func setupMocksForAutocomplete(for vc: KeyboardInputViewController) {
        let vc = vc as? TestClass
        vc?.autocompleteProvider = mockAutocompleteProvider
        vc?.textDocumentProxyValue = mockTextDocumentProxy
    }

    func expectOperationSyncsContext(for function: @escaping (UIViewController) -> Void) {
        let vc = TestClass(nibName: nil, bundle: nil)
        XCTAssertFalse(vc.keyboardContext.hasFullAccess)
        XCTAssertFalse(vc.keyboardContext.textDocumentProxy === vc.textDocumentProxy)
        vc.hasFullAccessValue = true
        eventually {
            vc.keyboardContext.hasFullAccess = false
            function(vc)
            self.eventually {
                XCTAssertTrue(vc.keyboardContext.hasFullAccess)
                XCTAssertTrue(vc.keyboardContext.textDocumentProxy === vc.textDocumentProxy)
            }
        }
    }


    // MARK: - View Controller Lifecycle

    func testViewDidLoadSetsVcAsShared() {
        XCTAssertFalse(TestClass.shared === vc)
        vc.viewDidLoad()
        XCTAssertTrue(TestClass.shared === vc)
    }

    func testViewDidLoadSetsUpContextObservations() {
        vc.viewDidLoad()
        XCTAssertTrue(vc.cancellables.count > 0)
    }

    func testViewWillAppearUpdatesContext() {
        expectOperationSyncsContext {
            $0.viewWillAppear(false)
        }
    }

    func testTraitCollectionDidChangeUpdatesContext() {
        expectOperationSyncsContext {
            $0.traitCollectionDidChange(.none)
        }
    }


    // MARK: - Setup

    func testSettingUpWithViewCreatesAndAddsKeyboardHostingController() {
        XCTAssertEqual(vc.children.count, 0)
        vc.setup(with: Text("HEJ"))
        XCTAssertEqual(vc.children.count, 1)
        XCTAssertEqual(vc.view.subviews.count, 1)
    }


    // MARK: - Properties

    func testTextDocumentProxyReturnsTheOriginalProxyIfNoInputProxyIsDefined() {
        XCTAssertTrue(vc.textDocumentProxy === vc.originalTextDocumentProxy)
    }

    func testTextDocumentProxyReturnsTheInputProxyIfOneIsSet() {
        let input = MockTextInput()
        let proxy = TextInputProxy(input: input)
        vc.textInputProxy = proxy
        XCTAssertTrue(vc.textDocumentProxy === proxy)
    }

    func testTextInputProxyMakesVcSyncWithProxy() {
        let vc = TestClass()
        vc.mock.resetCalls()
        let input = MockTextInput()
        let proxy = TextInputProxy(input: input)
        vc.textInputProxy = proxy
        eventually {
            XCTAssertTrue(vc.keyboardContext.textDocumentProxy === proxy)
        }
    }



    // MARK: - Observables

    func testObservablePropertiesHaveStandardValuesByDefault() {
        let vc = TestClass()
        eventually {
            XCTAssertEqual(vc.actionCalloutContext.buttonFrame, .zero)
            XCTAssertTrue(vc.autocompleteContext.suggestions.isEmpty)
            XCTAssertEqual(vc.inputCalloutContext.buttonFrame, .zero)
            XCTAssertFalse(vc.keyboardContext.hasFullAccess)
            XCTAssertEqual(vc.keyboardContext.keyboardType, .alphabetic(.lowercased))
            XCTAssertFalse(vc.keyboardContext.needsInputModeSwitchKey)
            XCTAssertEqual(vc.keyboardFeedbackSettings.audioConfiguration, .standard)
            XCTAssertEqual(vc.keyboardFeedbackSettings.hapticConfiguration, .standard)
        }
    }


    // MARK: - Services

    func servicesHaveStandardInstancesByDefault() {
        XCTAssertNotNil(vc.autocompleteProvider as? DisabledAutocompleteProvider)
        XCTAssertNotNil(vc.calloutActionProvider as? StandardCalloutActionProvider)
        XCTAssertNotNil(vc.inputSetProvider as? StandardInputSetProvider)
        XCTAssertNotNil(vc.keyboardActionHandler as? StandardKeyboardActionHandler)
        XCTAssertNotNil(vc.keyboardAppearance as? StandardKeyboardAppearance)
        XCTAssertNotNil(vc.keyboardBehavior as? StandardKeyboardBehavior)
        XCTAssertNotNil(vc.keyboardFeedbackHandler as? StandardKeyboardFeedbackHandler)
        XCTAssertNotNil(vc.keyboardLayoutProvider as? StandardKeyboardLayoutProvider)
    }

    func verifyRefresh(for vc: KeyboardInputViewController) {
        let actionContext = vc.actionCalloutContext
        let layoutProvider = vc.keyboardLayoutProvider as? StandardKeyboardLayoutProvider
        XCTAssertTrue(layoutProvider?.inputSetProvider === vc.inputSetProvider)
        XCTAssertTrue(actionContext.actionHandler === vc.keyboardActionHandler)
    }

    func testRefreshingPropertiesWhenChangingServicePropertiesIsDoneForKeyboardActionHandler() {
        let vc = TestClass()
        vc.keyboardActionHandler = MockKeyboardActionHandler()
        verifyRefresh(for: vc)
    }

    func testRefreshingPropertiesWhenChangingServicePropertiesIsDoneForInputSetProvider() {
        let vc = TestClass()
        vc.inputSetProvider = MockInputSetProvider()
        verifyRefresh(for: vc)
    }

    func testRefreshingPropertiesWhenChangingServicePropertiesIsForCalloutActionProvider() {
        let vc = TestClass()
        vc.calloutActionProvider = StandardCalloutActionProvider(keyboardContext: .preview)
        verifyRefresh(for: vc)
    }


    // MARK: - Text And Selection Change

    func testSelectionWillChangeTriggersResetAutocomplete() {
        XCTAssertFalse(vc.hasCalled(vc.resetAutocompleteRef))
        vc.selectionWillChange(nil)
        XCTAssertTrue(vc.hasCalled(vc.resetAutocompleteRef))
    }

    func testSelectionDidChangeTriggersResetAutocomplete() {
        XCTAssertFalse(vc.hasCalled(vc.resetAutocompleteRef))
        vc.selectionDidChange(nil)
        XCTAssertTrue(vc.hasCalled(vc.resetAutocompleteRef))
    }

    func testTextWillChangeTriggersViewWillSyncWithTextDocumentProxy() {
        vc.textWillChange(nil)
        XCTAssertTrue(vc.keyboardContext.textDocumentProxy === vc.textDocumentProxy)
    }

    func testTextDidChangeTriggersPerformAutocomplete() {
        XCTAssertFalse(vc.hasCalled(vc.performAutocompleteRef))
        vc.textDidChange(nil)
        XCTAssertTrue(vc.hasCalled(vc.performAutocompleteRef))
    }

    func testTextDidChangeTriesToChangeKeyboardType() {
        vc.keyboardContext.keyboardType = .alphabetic(.lowercased)
        vc.textDidChange(nil)
        vc.keyboardContext.keyboardType = .alphabetic(.uppercased)
    }


    // MARK: - Observation

    func testChangingKeyboardLocaleReplacesLocaleOfAllLocaleBasedDependencies() {
        let vc = TestClass()
        let locale = KeyboardLocale.swedish
        vc.viewDidLoad()
        vc.keyboardContext.locale = locale.locale
        eventually {
            XCTAssertEqual(vc.autocompleteProvider.locale, locale.locale)
        }
    }


    // MARK: - Autocomplete

    func testPerformingAutocompleteAbortsIfTextProxyHasNoCurrentWord() {
        let vc = TestClass()
        setupMocksForAutocomplete(for: vc)
        mockAutocompleteProvider.autocompleteSuggestionsResult = .success([StandardAutocompleteSuggestion(text: "")])
        mockTextDocumentProxy.documentContextBeforeInput = "foo bar"
        vc.performAutocomplete()
        eventually {
            XCTAssertEqual(vc.autocompleteContext.suggestions.count, 1)
        }
    }

    func testPerformingAutocompleteWritesResultToAutocompleteContext() {
        let vc = TestClass()
        setupMocksForAutocomplete(for: vc)
        mockAutocompleteProvider.autocompleteSuggestionsResult = .success([StandardAutocompleteSuggestion(text: "")])
        vc.performAutocomplete()
        eventually {
            XCTAssertEqual(vc.autocompleteContext.suggestions.count, 0)
        }
    }

    func testResettingAutocompleteWritesResultToAutocompleteContext() {
        vc.autocompleteContext.suggestions = [StandardAutocompleteSuggestion(text: "")]
        vc.resetAutocomplete()
        XCTAssertEqual(vc.autocompleteContext.suggestions.count, 0)
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
#endif

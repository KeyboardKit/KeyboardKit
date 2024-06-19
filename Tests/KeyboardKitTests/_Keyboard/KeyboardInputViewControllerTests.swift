//
//  KeyboardInputViewControllerTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import MockingKit
import SwiftUI
import XCTest

@testable import KeyboardKit

class KeyboardInputViewControllerTests: XCTestCase {
    
    private var vc: TestClass!

    private let mockAutocompleteService = Autocomplete.DisabledService()
    private let mockTextDocumentProxy = MockTextDocumentProxy()

    override func setUp() {
        vc = TestClass(nibName: nil, bundle: nil)
    }

    func setupMocksForAutocomplete(for vc: KeyboardInputViewController) {
        let vc = vc as? TestClass
        vc?.services.autocompleteService = mockAutocompleteService
        vc?.textDocumentProxyValue = mockTextDocumentProxy
    }

    func expectOperationSyncsContext(for function: @escaping (UIViewController) -> Void) {
        let vc = TestClass(nibName: nil, bundle: nil)
        XCTAssertFalse(vc.state.keyboardContext.hasFullAccess)
        XCTAssertFalse(vc.state.keyboardContext.textDocumentProxy === vc.textDocumentProxy)
        vc.hasFullAccessValue = true
        eventually {
            vc.state.keyboardContext.hasFullAccess = false
            function(vc)
            self.eventually {
                XCTAssertTrue(vc.state.keyboardContext.hasFullAccess)
                XCTAssertTrue(vc.state.keyboardContext.textDocumentProxy === vc.textDocumentProxy)
            }
        }
    }


    // MARK: - View Controller Lifecycle

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
            XCTAssertTrue(vc.state.keyboardContext.textDocumentProxy === proxy)
        }
    }



    // MARK: - Observables

    func testObservablePropertiesHaveStandardValuesByDefault() {
        let vc = TestClass()
        eventually {
            XCTAssertEqual(vc.state.calloutContext.actionContext.buttonFrame, .zero)
            XCTAssertTrue(vc.state.autocompleteContext.suggestions.isEmpty)
            XCTAssertEqual(vc.state.calloutContext.inputContext.buttonFrame, .zero)
            XCTAssertFalse(vc.state.keyboardContext.hasFullAccess)
            XCTAssertEqual(vc.state.keyboardContext.keyboardType, .alphabetic(.auto))
            XCTAssertFalse(vc.state.keyboardContext.needsInputModeSwitchKey)
            XCTAssertEqual(vc.state.feedbackContext.audioConfiguration, .enabled)
            XCTAssertEqual(vc.state.feedbackContext.hapticConfiguration, .minimal)
        }
    }


    // MARK: - Services

    func servicesHaveStandardInstancesByDefault() {
        XCTAssertNotNil(vc.services.actionHandler as? KeyboardAction.StandardHandler)
        XCTAssertNotNil(vc.services.autocompleteService as? Autocomplete.DisabledService)
        XCTAssertNotNil(vc.services.calloutActionProvider as? Callouts.StandardActionProvider)
        XCTAssertNotNil(vc.services.dictationService as? Dictation.DisabledKeyboardService)
        XCTAssertNotNil(vc.services.keyboardBehavior as? Keyboard.StandardBehavior)
        XCTAssertNotNil(vc.services.layoutProvider as? KeyboardLayout.StandardProvider)
        XCTAssertNotNil(vc.services.styleProvider as? KeyboardStyle.StandardProvider)
    }
    
    func testRefreshingPropertiesWhenChangingServicePropertiesIsDoneForKeyboardActionHandler() {
        let vc = TestClass()
        vc.services.actionHandler = .preview
        let actionContext = vc.state.calloutContext.actionContext
        XCTAssertTrue(actionContext.actionProvider === vc.services.calloutActionProvider)
    }

    func testRefreshingPropertiesWhenChangingServicePropertiesIsForCalloutActionProvider() {
        let vc = TestClass()
        vc.services.calloutActionProvider = Callouts.StandardActionProvider(keyboardContext: .preview)
        let actionContext = vc.state.calloutContext.actionContext
        XCTAssertTrue(actionContext.actionProvider === vc.services.calloutActionProvider)
    }


    // MARK: - Text And Selection Change

    func testSelectionWillChangeTriggersResetAutocomplete() {
        XCTAssertFalse(vc.hasCalled(\.resetAutocompleteRef))
        vc.selectionWillChange(nil)
        XCTAssertTrue(vc.hasCalled(\.resetAutocompleteRef))
    }

    func testSelectionDidChangeTriggersResetAutocomplete() {
        XCTAssertFalse(vc.hasCalled(\.resetAutocompleteRef))
        vc.selectionDidChange(nil)
        XCTAssertTrue(vc.hasCalled(\.resetAutocompleteRef))
    }

    func testTextWillChangeTriggersViewWillSyncWithTextDocumentProxy() {
        vc.textWillChange(nil)
        eventually {
            XCTAssertTrue(self.vc?.state.keyboardContext.textDocumentProxy === self.vc?.textDocumentProxy)
        }
    }

    func testTextDidChangeTriggersPerformAutocomplete() {
        XCTAssertFalse(vc.hasCalled(\.performAutocompleteRef))
        vc.textDidChange(nil)
        eventually {
            XCTAssertTrue(self.vc?.hasCalled(\.performAutocompleteRef) == true)
        }
    }

    func testTextDidChangeTriesToChangeKeyboardType() {
        vc.state.keyboardContext.keyboardType = .alphabetic(.lowercased)
        vc.textDidChange(nil)
        vc.state.keyboardContext.keyboardType = .alphabetic(.uppercased)
    }


    // MARK: - Observation

    func testChangingKeyboardLocaleReplacesLocaleOfAllLocaleBasedDependencies() {
        let vc = TestClass()
        let locale = KeyboardLocale.swedish
        vc.viewDidLoad()
        vc.state.keyboardContext.locale = locale.locale
        eventually {
            XCTAssertEqual(vc.services.autocompleteService.locale, locale.locale)
        }
    }


    // MARK: - Autocomplete

    func testAutocompleteTextIsCurrentWordInProxy() {
        let vc = TestClass()
        setupMocksForAutocomplete(for: vc)
        mockTextDocumentProxy.documentContextBeforeInput = "foo"
        mockTextDocumentProxy.documentContextAfterInput = "bar"
        XCTAssertEqual(vc.autocompleteText, "foo")
    }

    func testIsAutocompleteEnabledIsTrueIfProxyIsNotReadingFullDocumentContext() {
        let vc = TestClass()
        setupMocksForAutocomplete(for: vc)
        XCTAssertTrue(vc.isAutocompleteEnabled)
        mockTextDocumentProxy.isReadingFullDocumentContext = true
        XCTAssertFalse(vc.isAutocompleteEnabled)
        mockTextDocumentProxy.isReadingFullDocumentContext = false
        XCTAssertTrue(vc.isAutocompleteEnabled)
    }

    func testPerformingAutocompleteAbortsIfProxyIsReadingFullDocumentContext() {
        let vc = TestClass()
        setupMocksForAutocomplete(for: vc)
        vc.state.autocompleteContext.suggestions = [.init(text: "")]
        mockTextDocumentProxy.isReadingFullDocumentContext = true
        vc.performAutocomplete()
        mockTextDocumentProxy.isReadingFullDocumentContext = false
        eventually {
            XCTAssertEqual(vc.state.autocompleteContext.suggestions.count, 1)
        }
    }

    func testPerformingAutocompleteAbortsIfTextProxyHasNoCurrentWord() {
        let vc = TestClass()
        setupMocksForAutocomplete(for: vc)
        vc.state.autocompleteContext.suggestions = [.init(text: "")]
        mockTextDocumentProxy.documentContextBeforeInput = nil
        mockTextDocumentProxy.documentContextAfterInput = nil
        XCTAssertNil(vc.autocompleteText)
        vc.performAutocomplete()
        eventually {
            XCTAssertEqual(vc.state.autocompleteContext.suggestions.count, 0)
        }
    }

    func testPerformingAutocompleteWritesResultToAutocompleteContext() {
        let vc = TestClass()
        setupMocksForAutocomplete(for: vc)
        mockAutocompleteService.suggestions = [.init(text: "")]
        vc.performAutocomplete()
        eventually {
            let suggestions = vc.state.autocompleteContext.suggestions
            XCTAssertEqual(suggestions.count, 1)
        }
    }

    func testResettingAutocompleteWritesResultToAutocompleteContext() {
        vc.state.autocompleteContext.suggestions = [.init(text: "")]
        vc.resetAutocomplete()
        XCTAssertEqual(vc.state.autocompleteContext.suggestions.count, 0)
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

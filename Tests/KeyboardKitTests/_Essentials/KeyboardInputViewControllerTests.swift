//
//  KeyboardInputViewControllerTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import MockingKit
import SwiftUI
import XCTest

@testable import KeyboardKit

class KeyboardInputViewControllerTests: XCTestCase {
    
    private var vc: TestClass!

    private let mockAutocompleteService = Autocomplete.DisabledAutocompleteService()
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
        vc.setupKeyboardView(with: Text("HEJ"))
        XCTAssertEqual(vc.children.count, 1)
        XCTAssertEqual(vc.view.subviews.count, 1)
    }


    // MARK: - Properties

    func testTextDocumentProxyReturnsTheOriginalProxyIfNoInputProxyIsDefined() {
        XCTAssertTrue(vc.textDocumentProxy === vc.originalTextDocumentProxy)
    }

    func testTextDocumentProxyReturnsTheInputProxyIfOneIsSet() {
        let proxy = MockTextDocumentProxy()
        vc.state.keyboardContext.textInputProxy = proxy
        XCTAssertTrue(vc.textDocumentProxy === proxy)
    }

    func testTextInputProxyMakesVcSyncWithProxy() {
        let vc = TestClass()
        vc.mock.resetCalls()
        let proxy = MockTextDocumentProxy()
        vc.state.keyboardContext.textInputProxy = proxy
        eventually {
            XCTAssertTrue(vc.state.keyboardContext.textDocumentProxy === proxy)
        }
    }



    // MARK: - Observables

    func testObservablePropertiesHaveStandardValuesByDefault() {
        let vc = TestClass()
        eventually {
            XCTAssertEqual(vc.state.calloutContext.buttonFrame, .zero)
            XCTAssertTrue(vc.state.autocompleteContext.suggestions.isEmpty)
            XCTAssertEqual(vc.state.calloutContext.buttonFrame, .zero)
            XCTAssertFalse(vc.state.keyboardContext.hasFullAccess)
            XCTAssertEqual(vc.state.keyboardContext.keyboardType, .alphabetic)
            XCTAssertFalse(vc.state.keyboardContext.needsInputModeSwitchKey)
            XCTAssertEqual(vc.state.feedbackContext.audioConfiguration, .standard)
            XCTAssertEqual(vc.state.feedbackContext.hapticConfiguration, .standard)
        }
    }


    // MARK: - Services

    func servicesHaveStandardInstancesByDefault() {
        XCTAssertNotNil(vc.services.actionHandler as? KeyboardAction.StandardActionHandler)
        XCTAssertNotNil(vc.services.autocompleteService as? Autocomplete.DisabledAutocompleteService)
        XCTAssertNotNil(vc.services.calloutService as? KeyboardCallout.StandardCalloutService)
        XCTAssertNotNil(vc.services.dictationService as? Dictation.DisabledDictationService)
        XCTAssertNotNil(vc.services.keyboardBehavior as? Keyboard.StandardKeyboardBehavior)
        XCTAssertNotNil(vc.services.layoutService as? KeyboardLayout.StandardLayoutService)
        XCTAssertNotNil(vc.services.styleService as? KeyboardStyle.StandardStyleService)
    }
    
    func testRefreshingPropertiesWhenChangingServicePropertiesIsDoneForKeyboardActionHandler() {
        let vc = TestClass()
        vc.services.actionHandler = .preview
        let actionContext = vc.state.calloutContext
        XCTAssertTrue(actionContext.calloutService === vc.services.calloutService)
    }

    func testRefreshingPropertiesWhenChangingServicePropertiesIsDoneForCalloutService() {
        let vc = TestClass()
        vc.services.calloutService = KeyboardCallout.StandardCalloutService(keyboardContext: .preview)
        let actionContext = vc.state.calloutContext
        XCTAssertTrue(actionContext.calloutService === vc.services.calloutService)
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
        vc.state.keyboardContext.keyboardType = .numeric
        vc.textDidChange(nil)
        vc.state.keyboardContext.keyboardType = .alphabetic
    }


    // MARK: - Observation

    func testChangingLocaleReplacesLocaleOfAllLocaleBasedDependencies() {
        let vc = TestClass()
        let locale = Locale.swedish
        vc.viewDidLoad()
        vc.state.keyboardContext.locale = locale
        eventually {
            XCTAssertEqual(vc.services.autocompleteService.locale, locale)
        }
    }


    // MARK: - Autocomplete

    func testAutocompleteTextIsAllTextBeforeTheInputCursor() {
        let vc = TestClass()
        setupMocksForAutocomplete(for: vc)
        mockTextDocumentProxy.documentContextBeforeInput = "foo bar "
        mockTextDocumentProxy.documentContextAfterInput = "baz"
        XCTAssertEqual(vc.autocompleteText, "foo bar ")
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
        vc.lastAutocompleteText = "something to trigger this"
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
        vc.lastAutocompleteText = "something to trigger this"
        setupMocksForAutocomplete(for: vc)
        mockAutocompleteService.suggestions = [.init(text: "")]
        vc.performAutocomplete()
        eventually {
            let suggestions = vc.state.autocompleteContext.suggestions
            XCTAssertEqual(suggestions.count, 1)
        }
    }

    func testResettingAutocompleteWritesResultToAutocompleteContext() async {
        await vc.state.autocompleteContext.suggestions = [.init(text: "")]
        await vc.resetAutocomplete()
        try? await Task.sleep(nanoseconds: 1)
        let suggestions = await vc.state.autocompleteContext.suggestions
        XCTAssertEqual(suggestions.count, 0)
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

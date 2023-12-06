//
//  KeyboardViewController.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-03-13.
//  Copyright © 2018-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import Combine
import SwiftUI
import UIKit

/**
 This class extends `UIInputViewController` with KeyboardKit
 specific functionality.

 Let your `KeyboardController` inherit this class instead of
 `UIInputViewController` to get new lifecycle functions like
 ``viewWillSetupKeyboard()``, observable ``state``, standard
 ``services``, and much more.

 The controller can override any function, modify or replace
 any state or service property, and injects its ``state`` as
 environment objects into the view hierarchy.
 */
open class KeyboardInputViewController: UIInputViewController, KeyboardController {


    // MARK: - View Controller Lifecycle

    open override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        viewWillRegisterSharedController()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillSetupKeyboard()
        viewWillSyncWithContext()
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewWillHandleDictationResult()
    }

    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        state.keyboardContext.syncAfterLayout(with: self)
    }

    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        viewWillSyncWithContext()
        super.traitCollectionDidChange(previousTraitCollection)
    }


    // MARK: - Keyboard View Controller Lifecycle

    /**
     This function is called to handle any dictation results
     when returning from the main app.
     */
    open func viewWillHandleDictationResult() {
        Task {
            do {
                try await services.dictationService.handleDictationResultInKeyboard()
            } catch {
                await updateLastDictationError(error)
            }
        }
    }

    /**
     This function is called when the controller is about to
     register itself as the shared controller.
     */
    open func viewWillRegisterSharedController() {
        NextKeyboardController.shared = self
        KeyboardUrlOpener.shared.controller = self
    }

    /**
     This function is called whenever the keyboard view must
     be setup. It will by default setup a ``SystemKeyboard``.
     */
    open func viewWillSetupKeyboard() {
        setup { controller in
            SystemKeyboard(
                state: controller.state,
                services: controller.services,
                buttonContent: { $0.view },
                buttonView: { $0.view },
                emojiKeyboard: { $0.view },
                toolbar: { $0.view }
            )
        }
    }

    /**
     This function is called whenever the controller must be
     synced with its ``keyboardContext``.
     */
    open func viewWillSyncWithContext() {
        performKeyboardContextSync()
    }


    // MARK: - Setup

    /// Setup KeyboardKit with a custom keyboard view.
    open func setup<Content: View>(
        with view: @autoclosure @escaping () -> Content
    ) {
        setup(withRootView: Keyboard.RootView(view))
    }
    
    /// Setup KeyboardKit with a custom keyboard view.
    open func setup<Content: View>(
        with view: @escaping (_ controller: KeyboardInputViewController) -> Content
    ) {
        setup(withRootView: Keyboard.RootView { [unowned self] in
            view(self)
        })
    }


    // MARK: - Combine

    var cancellables = Set<AnyCancellable>()


    // MARK: - Properties
    
    /// The original text document proxy.
    open var originalTextDocumentProxy: UITextDocumentProxy {
        super.textDocumentProxy
    }
    
    /// The error that was thrown during a pro setup, if any.
    public var setupProError: Error?

    /// The text document proxy that is currently active.
    open override var textDocumentProxy: UITextDocumentProxy {
        textInputProxy ?? originalTextDocumentProxy
    }

    /// A custom text proxy to which text can be routed.
    public var textInputProxy: TextInputProxy? {
        didSet { viewWillSyncWithContext() }
    }


    // MARK: - Keyboard Properties
    
    /// The default set of keyboard-specific services.
    public lazy var services: Keyboard.KeyboardServices = {
        let services = Keyboard.KeyboardServices(state: state)
        services.setup(for: self)
        return services
    }()
    
    /// The default set of keyboard-specific state.
    public lazy var state: Keyboard.KeyboardState = {
        let state = Keyboard.KeyboardState()
        state.setup(for: self)
        return state
    }()



    // MARK: - Text And Selection Change

    open override func selectionWillChange(_ textInput: UITextInput?) {
        super.selectionWillChange(textInput)
        resetAutocomplete()
    }

    open override func selectionDidChange(_ textInput: UITextInput?) {
        super.selectionDidChange(textInput)
        resetAutocomplete()
    }

    open override func textWillChange(_ textInput: UITextInput?) {
        super.textWillChange(textInput)
        state.keyboardContext.syncTextDocumentProxy(with: self)
        state.keyboardContext.syncTextInputProxy(with: self)
    }
    
    open override func textDidChange(_ textInput: UITextInput?) {
        super.textDidChange(textInput)
        DispatchQueue.main.async { [weak self] in
            self?.textDidChangeAsync(textInput)
        }
    }
    
    /// This function will be called with an async delay, to
    /// give the text document proxy time to update itself.
    open func textDidChangeAsync(_ textInput: UITextInput?) {
        performAutocomplete()
        tryChangeToPreferredKeyboardTypeAfterTextDidChange()
    }


    // MARK: - KeyboardController
    
    open func adjustTextPosition(by offset: Int) {
        textDocumentProxy.adjustTextPosition(byCharacterOffset: offset)
    }

    open func deleteBackward() {
        textDocumentProxy.deleteBackward(range: services.keyboardBehavior.backspaceRange)
    }

    open func deleteBackward(times: Int) {
        textDocumentProxy.deleteBackward(times: times)
    }

    open func insertText(_ text: String) {
        textDocumentProxy.insertText(text)
    }

    open func selectNextLocale() {
        state.keyboardContext.selectNextLocale()
    }

    open func setKeyboardType(_ type: Keyboard.KeyboardType) {
        state.keyboardContext.keyboardType = type
    }

    open func openUrl(_ url: URL?) {
        let selector = sel_registerName("openURL:")
        var responder = self as UIResponder?
        while let r = responder, !r.responds(to: selector) {
            responder = r.next
        }
        _ = responder?.perform(selector, with: url)
    }


    // MARK: - Syncing

    /**
     Whether or not context syncing is enabled.

     By default, context sync is enabled as long as the text
     text document proxy isn't reading full document context.
     */
    open var isContextSyncEnabled: Bool {
        !textDocumentProxy.isReadingFullDocumentContext
    }
    
    /**
     Perform a text context sync.

     This is performed to ensure that ``keyboardContext`` is
     synced. It aborts if ``isContextSyncEnabled`` is `false`.
     */
    open func performKeyboardContextSync() {
        guard isContextSyncEnabled else { return }
        state.keyboardContext.sync(with: self)
    }


    // MARK: - Autocomplete

    /// The text to use when performing autocomplete.
    open var autocompleteText: String? {
        textDocumentProxy.currentWord
    }

    /// Whether or not autocomple is enabled.
    open var isAutocompleteEnabled: Bool {
        guard state.autocompleteContext.isAutocompleteEnabled else { return false }
        return !textDocumentProxy.isReadingFullDocumentContext
    }

    /// Perform an autocomplete operation.
    open func performAutocomplete() {
        guard isAutocompleteEnabled else { return }
        guard let text = autocompleteText else { return resetAutocomplete() }
        Task {
            do {
                let suggestions = try await services.autocompleteProvider
                    .autocompleteSuggestions(for: text)
                updateAutocompleteContext(with: suggestions)
            } catch {
                updateAutocompleteContext(with: error)
            }
        }
    }

    /// Reset the current autocomplete state.
    open func resetAutocomplete() {
        state.autocompleteContext.reset()
    }


    // MARK: - Dictation

    /// Perform a keyboard-initiated dictation operation.
    public func performDictation() {
        Task {
            do {
                try await services.dictationService.startDictationFromKeyboard(with: state.dictationConfig)
            } catch {
                await updateLastDictationError(error)
            }
        }
    }
}

// MARK: - Private Functions

private extension KeyboardInputViewController {

    func tryChangeToPreferredKeyboardTypeAfterTextDidChange() {
        let shouldSwitch = services.keyboardBehavior.shouldSwitchToPreferredKeyboardTypeAfterTextDidChange()
        guard shouldSwitch else { return }
        setKeyboardType(state.keyboardContext.preferredKeyboardType)
    }

    /// Update the autocomplete context with an error.
    func updateAutocompleteContext(with error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.state.autocompleteContext.lastError = error
        }
    }
    
    /// Update the autocomplete context with new suggestions.
    func updateAutocompleteContext(with result: [Autocomplete.Suggestion]) {
        DispatchQueue.main.async { [weak self] in
            self?.state.autocompleteContext.suggestions = result
        }
    }
    
    func updateLastDictationError(_ error: Error) async {
        await MainActor.run {
            state.dictationContext.lastError = error
        }
    }
}

public extension View {
    
    func withEnvironment(
        fromController controller: KeyboardInputViewController
    ) -> some View {
        self.withEnvironment(fromState: controller.state)
    }
}
#endif

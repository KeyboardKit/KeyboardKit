//
//  KeyboardViewController.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-03-13.
//  Copyright © 2018-2024 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(visionOS)
import Combine
import SwiftUI
import UIKit

/// This is the main input controller in a KeyboardKit-based
/// keyboard extension.
///
/// When using KeyboardKit, let `KeyboardController` inherit
/// this class instead of `UIInputViewController`, to extend
/// it with KeyboardKit-specific functionality.
///
/// You can override any functions, modify any ``state`` and
/// replace any ``services`` to tweak your keyboard behavior.
/// You also get a lot of additional controller features.
///
/// > Warning: A very important thing that you MUST consider
/// when you use `setup` or `setupPro` with a `view` builder,
/// is that the `view` builder provides you with an `unowned`
/// controller reference, since referring to `self` from the
/// view builder can cause memory leaks. However, since this
/// reference is a ``KeyboardInputViewController``, you must
/// still use `self` when you have to refer to your specific
/// controller class. If you do, it is VERY important to add
/// `[weak self]` or `[unowned self]` to the builder. If you
/// don't, the `self` reference will cause a memory leak.
///
/// See the <doc:Getting-Started> guide and <doc:Essentials>
/// article for more information about how to set up and use
/// this keyboard controller class.
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

    /// This function is called to handle a dictation result
    /// when returning from the main app.
    open func viewWillHandleDictationResult() {
        Task {
            do {
                try await services.dictationService.handleDictationResultInKeyboard()
            } catch {
                await updateLastDictationError(error)
            }
        }
    }

    /// This function is called when the controller is about
    /// to register itself as the shared controller.
    open func viewWillRegisterSharedController() {
        KeyboardUrlOpenerInternal.controller = self         // Remore in KeyboardKit 9.0
        Keyboard.NextKeyboardController.shared = self
    }

    /// This function is called when a keyboard view must be
    /// created. It will by default setup a ``SystemKeyboard``.
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

    /// This function is called when the controller is about
    /// to sync with the ``Keyboard/KeyboardState`` contexts.
    open func viewWillSyncWithContext() {
        performKeyboardContextSync()
    }


    // MARK: - Setup
    
    /// The error that was thrown during a pro setup, if any.
    public var setupProError: Error?

    /// Setup KeyboardKit with a custom keyboard view.
    ///
    /// > Warning: Make sure to read the class documentation
    /// for important information on the unowned `controller`
    /// reference that is passed to the `view` builder. Make
    /// sure to use `[weak self]` or `[unowned self]` if the
    /// `view` builder needs to refer to your specific class.
    open func setup<Content: View>(
        with view: @autoclosure @escaping () -> Content
    ) {
        setup(withRootView: Keyboard.RootView(view))
    }
    
    /// Setup KeyboardKit with a custom keyboard view.
    ///
    /// > Warning: Make sure to read the class documentation
    /// for important information on the unowned `controller`
    /// reference that is passed to the `view` builder. Make
    /// sure to use `[weak self]` or `[unowned self]` if the
    /// `view` builder needs to refer to your specific class.
    open func setup<Content: View>(
        with view: @escaping (_ controller: KeyboardInputViewController) -> Content
    ) {
        setup(withRootView: Keyboard.RootView { [unowned self] in
            view(self)
        })
    }


    // MARK: - Combine

    var cancellables = Set<AnyCancellable>()


    // MARK: - Proxy Properties
    
    /// The original text document proxy.
    open var originalTextDocumentProxy: UITextDocumentProxy {
        super.textDocumentProxy
    }

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
    public lazy var services: Keyboard.Services = {
        let services = Keyboard.Services(state: state)
        services.setup(for: self)
        return services
    }()
    
    /// The default set of keyboard-specific state.
    public lazy var state: Keyboard.State = {
        let state = Keyboard.State()
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

    /// Whether or not context syncing is enabled.
    ///
    /// By default, syncung is enabled while a text document
    /// proxy isn't reading full the document context.
    open var isContextSyncEnabled: Bool {
        !textDocumentProxy.isReadingFullDocumentContext
    }
    
    /// Perform a keyboard context sync.
    ///
    /// This is performed to keep the ``state`` in sync, and
    /// will abort if ``isContextSyncEnabled`` is `false`.
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
        Task {
            do {
                let suggestions = try await services.autocompleteProvider
                    .autocompleteSuggestions(for: autocompleteText ?? "")
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
                try await services.dictationService
                    .startDictationFromKeyboard(with: state.dictationConfig)
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
    
    func keyboardState(
        from controller: KeyboardInputViewController
    ) -> some View {
        self.keyboardState(controller.state)
    }
    
    @available(*, deprecated, renamed: "keyboardState(from:)")
    func withEnvironment(
        fromController controller: KeyboardInputViewController
    ) -> some View {
        self.keyboardState(from: controller)
    }
}
#endif

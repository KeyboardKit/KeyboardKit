//
//  KeyboardViewController.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-03-13.
//  Copyright © 2018-2023 Daniel Saidi. All rights reserved.
//

public extension Keyboard {

    
}

#if os(iOS) || os(tvOS)
import Combine
import SwiftUI
import UIKit

/**
 This class extends `UIInputViewController` with KeyboardKit
 specific functionality.

 When you use KeyboardKit in a keyboard extension, just make
 your `KeyboardController` inherit this class instead of the
 standard `UIInputViewController`.
 
 This will add a lot of additional features and capabilities
 to the controller, like new lifecycle functions, properties,
 services, etc. For instance, ``viewWillSetupKeyboard()`` is
 called when the keyboard view should be created or rendered,
 ``keyboardContext`` has observable keyboard states, and the
 ``keyboardActionHandler`` can be used to handle action.

 Your controller can then override any functions, change any
 state, and replace any service to customize the behavior of
 the keyboard. It will also inject observable state into the
 view hierarchy, as environment objects,

 For instance, you can access ``keyboardContext`` like this:

 ```swift
 struct MyView: View {

     @EnvironmentObject
     private var keyboardContext: KeyboardContext

     ...
 }
 ```

 You may notice that KeyboardKit uses initializer parameters
 instead of environment objects. It's intentional, to better
 communicate the dependencies of each view.
 */
open class KeyboardInputViewController: UIInputViewController, KeyboardController {


    // MARK: - View Controller Lifecycle

    open override func viewDidLoad() {
        super.viewDidLoad()
        refreshServiceBasedProperties()
        setupInitialWidth()
        setupLocaleObservation()
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
                await MainActor.run {
                    state.dictationContext.lastError = error
                }
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
     be created or updated.

     This will by default set up a ``SystemKeyboard`` as the
     main view, but you can override it to use a custom view.
     */
    open func viewWillSetupKeyboard() {
        setup { controller in
            SystemKeyboard(
                controller: controller,
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

     This will by default sync with keyboard contexts if the
     ``isContextSyncEnabled`` property is set to `true`.
     */
    open func viewWillSyncWithContext() {
        guard isContextSyncEnabled else { return }
        state.keyboardContext.sync(with: self)
        state.keyboardTextContext.sync(with: self)
    }


    // MARK: - Setup

    /**
     Setup KeyboardKit with a custom SwiftUI view.

     Make sure to use the controller-based setup function if
     your view needs to refer to the controller.
     */
    open func setup<Content: View>(
        with view: @autoclosure @escaping () -> Content
    ) {
        setup(withRootView: Keyboard.RootView(view))
    }

    /**
     Setup KeyboardKit with a custom SwiftUI view.

     Make sure to use the controller-based setup function if
     your view needs to refer to the controller.
     */
    open func setup<Content: View>(
        with view: @escaping () -> Content
    ) {
        setup(withRootView: Keyboard.RootView(view))
    }

    /**
     Setup KeyboardKit with a controller-based SwiftUI view.
     
     This function uses an `unowned` controller reference to
     avoid memory leaks when referring to the controller.
     */
    open func setup<Content: View>(
        with view: @escaping (_ controller: KeyboardInputViewController) -> Content
    ) {
        setup(withRootView: Keyboard.RootView { [unowned self] in
            view(self)
        })
    }

    /**
     This internal function is shared by all setup functions.
     */
    func setup<Content: View>(withRootView view: Content) {
        self.children.forEach { $0.removeFromParent() }
        self.view.subviews.forEach { $0.removeFromSuperview() }
        let view = view.withEnvironment(from: self)
        let host = KeyboardHostingController(rootView: view)
        host.add(to: self)
    }


    // MARK: - Combine

    var cancellables = Set<AnyCancellable>()


    // MARK: - Properties
    
    /**
     The original text document proxy.

     This stays the same even when ``textInputProxy`` is set
     to make ``textDocumentProxy`` return a custom instance.
     */
    open var originalTextDocumentProxy: UITextDocumentProxy {
        super.textDocumentProxy
    }

    /**
     The text document proxy to use.
     
     This either returns the ``textInputProxy`` if set, else
     the ``mainTextDocumentProxy``.
     */
    open override var textDocumentProxy: UITextDocumentProxy {
        textInputProxy ?? originalTextDocumentProxy
    }

    /**
     A custom text input proxy, to which text can be routed.

     Setting this property make ``textDocumentProxy`` return
     this proxy instead of the ``mainTextDocumentProxy`` one.
     */
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
        if state.keyboardContext.textDocumentProxy === textDocumentProxy { return }
        state.keyboardContext.textDocumentProxy = textDocumentProxy
    }

    open override func textDidChange(_ textInput: UITextInput?) {
        super.textDidChange(textInput)
        performAutocomplete()
        performTextContextSync()
        tryChangeToPreferredKeyboardTypeAfterTextDidChange()
    }


    // MARK: - KeyboardController

    open func adjustTextPosition(byCharacterOffset offset: Int) {
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

    open func selectNextKeyboard() {}

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

     This is performed anytime the text is changed to ensure
     that ``keyboardTextContext`` is synced with the current
     text document context content.
     */
    open func performTextContextSync() {
        guard isContextSyncEnabled else { return }
        state.keyboardTextContext.sync(with: self)
    }


    // MARK: - Autocomplete

    /**
     The text that is provided to the ``autocompleteProvider``
     when ``performAutocomplete()`` is called.

     By default, the text document proxy's current word will
     be used. You can override this property to change that.
     */
    open var autocompleteText: String? {
        textDocumentProxy.currentWord
    }

    /**
     Insert an autocomplete suggestion into the document.

     By default, this call the `insertAutocompleteSuggestion`
     in the text document proxy, and then triggers a release
     in the keyboard action handler.
     */
    open func insertAutocompleteSuggestion(_ suggestion: Autocomplete.Suggestion) {
        textDocumentProxy.insertAutocompleteSuggestion(suggestion)
        services.actionHandler.handle(.release, on: .character(""))
    }

    /**
     Whether or not autocomple is enabled.

     By default, autocomplete is enabled as long as the text
     document proxy isn't reading full document context, and
     ``AutocompleteContext/isEnabled`` is `true`.
     */
    open var isAutocompleteEnabled: Bool {
        state.autocompleteContext.isEnabled && !textDocumentProxy.isReadingFullDocumentContext
    }

    /**
     Perform an autocomplete operation.

     You can override this function to extend or replace the
     default logic. By default, it uses the `currentWord` of
     the ``textDocumentProxy`` to perform autocomplete using
     the current ``autocompleteProvider``.
     */
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

    /**
     Reset the current autocomplete state.

     You can override this function to extend or replace the
     default logic. By default, it resets the suggestions in
     the ``autocompleteContext``.
     */
    open func resetAutocomplete() {
        state.autocompleteContext.reset()
    }


    // MARK: - Dictation

    /**
     The configuration to use when performing dictation from
     the keyboard extension.

     By default, this uses the `appGroupId` and `appDeepLink`
     properties from ``dictationContext``, so make sure that
     you call ``DictationContext/setup(with:)`` before using
     the dictation features in your keyboard extension.
     */
    public var dictationConfig: Dictation.KeyboardConfiguration {
        .init(
            appGroupId: state.dictationContext.appGroupId ?? "",
            appDeepLink: state.dictationContext.appDeepLink ?? ""
        )
    }

    /**
     Perform a keyboard-initiated dictation operation.

     > Important: ``DictationContext/appDeepLink`` must have
     been set before this is called. The link must open your
     app and start dictation. See the docs for more info.
     */
    public func performDictation() {
        Task {
            do {
                try await services.dictationService.startDictationFromKeyboard(with: dictationConfig)
            } catch {
                await MainActor.run {
                    state.dictationContext.lastError = error
                }
            }
        }
    }
    

    // MARK: - Deprecated
    
    @available(*, deprecated, renamed: "originalTextDocumentProxy")
    open var mainTextDocumentProxy: UITextDocumentProxy {
        originalTextDocumentProxy
    }
}


// MARK: - Internal Functions

extension KeyboardInputViewController {
    
    func refreshServiceBasedProperties() {
        refreshCalloutContext()
    }
}


// MARK: - Private Functions

private extension KeyboardInputViewController {

    func refreshCalloutContext() {
        let isPhone = UIDevice.current.userInterfaceIdiom == .phone
        state.calloutContext.actionContext.actionProvider = services.calloutActionProvider
        state.calloutContext.actionContext.tapAction = { [weak self] action in
            self?.services.actionHandler.handle(.release, on: action)
        }
        state.calloutContext.inputContext.isEnabled = isPhone
    }

    /**
     Set up an initial width to avoid broken SwiftUI layouts.
     */
    func setupInitialWidth() {
        view.frame.size.width = UIScreen.main.bounds.width
    }

    /**
     Setup locale observation to handle locale-based changes.
     */
    func setupLocaleObservation() {
        state.keyboardContext.$locale.sink { [weak self] in
            guard let self = self else { return }
            let locale = $0
            self.primaryLanguage = locale.identifier
            self.services.autocompleteProvider.locale = locale
        }.store(in: &cancellables)
    }

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
}

public extension View {
    
    func withEnvironment(from controller: KeyboardInputViewController) -> some View {
        self.withEnvironment(from: controller.state)
    }
}
#endif

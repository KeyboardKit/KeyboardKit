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

 When you use KeyboardKit, simply inherit this class instead
 of `UIInputViewController` to extend your controller with a
 set of additional lifecycle functions, properties, services
 etc. such as ``viewWillSetupKeyboard()``, ``keyboardContext``
 and ``keyboardActionHandler``.

 Your controller can then override any functions and replace
 any services to customize the behavior of the keyboard. You
 can also access any observable state as environment objects,
 since they are injected into the view hiearchy.

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
        keyboardContext.syncAfterLayout(with: self)
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
                try await dictationService.handleDictationResultInKeyboard()
            } catch {
                await MainActor.run {
                    dictationContext.lastError = error
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
        setup {
            SystemKeyboard(
                controller: $0,
                buttonContent: { $1 },
                buttonView: { $1 }
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
        keyboardContext.sync(with: self)
        keyboardTextContext.sync(with: self)
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
        setup(withRootView: KeyboardRootView(view))
    }

    /**
     Setup KeyboardKit with a custom SwiftUI view.

     Make sure to use the controller-based setup function if
     your view needs to refer to the controller.
     */
    open func setup<Content: View>(
        with view: @escaping () -> Content
    ) {
        setup(withRootView: KeyboardRootView(view))
    }

    /**
     Setup KeyboardKit with a controller-based SwiftUI view.
     
     This function uses an `unowned` controller reference to
     avoid memory leaks when referring to the controller.
     */
    open func setup<Content: View>(
        with view: @escaping (_ controller: KeyboardInputViewController) -> Content
    ) {
        setup(withRootView: KeyboardRootView { [unowned self] in
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
    open var mainTextDocumentProxy: UITextDocumentProxy {
        super.textDocumentProxy
    }

    /**
     The text document proxy to use.
     
     This either returns the ``textInputProxy`` if set, else
     the ``mainTextDocumentProxy``.
     */
    open override var textDocumentProxy: UITextDocumentProxy {
        textInputProxy ?? mainTextDocumentProxy
    }

    /**
     A custom text input proxy, to which text can be routed.

     Setting this property make ``textDocumentProxy`` return
     this proxy instead of the ``mainTextDocumentProxy`` one.
     */
    public var textInputProxy: TextInputProxy? {
        didSet { viewWillSyncWithContext() }
    }


    // MARK: - Observables

    /**
     The default, observable autocomplete context.

     This context is used as global autocomplete state, e.g.
     for the currently displayed suggestions.
     */
    public lazy var autocompleteContext = AutocompleteContext()

    /**
     The default, observable callout context.

     This is used as global callout state, e.g. for callouts
     that show the currently typed character.
     */
    public lazy var calloutContext = CalloutContext(
        actionContext: .init(
            actionHandler: keyboardActionHandler,
            actionProvider: calloutActionProvider),
        inputContext: .init(
            isEnabled: UIDevice.current.userInterfaceIdiom == .phone)
    )

    /**
     The default, observable dictation context.

     This is used as global dictation state and will be used
     to communicate between an app and its keyboard.
     */
    public lazy var dictationContext = DictationContext()

    /**
     The default, observable keyboard context.

     This is used as global state for the keyboard's overall
     state and configuration like locale, device, screen etc.
     */
    public lazy var keyboardContext = KeyboardContext(controller: self)

    /**
     The default, observable feedback settings.

     This property is used as a global configuration for the
     keyboard's feedback, e.g. audio and haptic feedback.
     */
    public lazy var keyboardFeedbackSettings = KeyboardFeedbackSettings()

    /**
     The default, observable keyboard text context.

     This is used as global state to let you observe text in
     the ``textDocumentProxy``.
     */
    public lazy var keyboardTextContext = KeyboardTextContext()



    // MARK: - Services

    /**
     The autocomplete provider that is used to provide users
     with autocomplete suggestions.
     */
    public lazy var autocompleteProvider: AutocompleteProvider = .disabled

    /**
     The callout action provider that is used to provide the
     keyboard with secondary callout actions.
     */
    public lazy var calloutActionProvider: CalloutActionProvider = StandardCalloutActionProvider(
        keyboardContext: keyboardContext
    ) {
        didSet { refreshProperties() }
    }

    /**
     The dictation service that is used to perform dictation
     operation between the keyboard and the main app.
     */
    public lazy var dictationService: KeyboardDictationService = .disabled(
        context: dictationContext
    )

    /**
     The action handler that will be used by the keyboard to
     handle keyboard actions.
     */
    public lazy var keyboardActionHandler: KeyboardActionHandler = StandardKeyboardActionHandler(
        inputViewController: self
    ) {
        didSet { refreshProperties() }
    }

    /**
     The style provider that is used to customize the design
     of the keyboard, such as its colors, fonts etc.
     */
    public lazy var keyboardStyleProvider: KeyboardStyleProvider = StandardKeyboardStyleProvider(
        keyboardContext: keyboardContext)

    /**
     The behavior that is used to determine how the keyboard
     should behave when certain things happen.
     
     > Important: Whenever you replace the standard behavior
     with a custom one, do so before using any services that
     depend on it, or recreate those services if they should
     use the new behavior.
     */
    public lazy var keyboardBehavior: KeyboardBehavior = StandardKeyboardBehavior(
        keyboardContext: keyboardContext)

    /**
     This keyboard layout provider that is used to setup the
     complete set of keys and their layout.
     */
    public lazy var keyboardLayoutProvider: KeyboardLayoutProvider = StandardKeyboardLayoutProvider()



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
        if keyboardContext.textDocumentProxy === textDocumentProxy { return }
        keyboardContext.textDocumentProxy = textDocumentProxy
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
        textDocumentProxy.deleteBackward(range: keyboardBehavior.backspaceRange)
    }

    open func deleteBackward(times: Int) {
        textDocumentProxy.deleteBackward(times: times)
    }

    open func insertText(_ text: String) {
        textDocumentProxy.insertText(text)
    }

    open func selectNextKeyboard() {
        keyboardContext.selectNextLocale()
    }

    open func selectNextLocale() {
        keyboardContext.selectNextLocale()
    }

    open func setKeyboardType(_ type: Keyboard.KeyboardType) {
        keyboardContext.keyboardType = type
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
        keyboardTextContext.sync(with: self)
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
        keyboardActionHandler.handle(.release, on: .character(""))
    }

    /**
     Whether or not autocomple is enabled.

     By default, autocomplete is enabled as long as the text
     document proxy isn't reading full document context, and
     ``AutocompleteContext/isEnabled`` is `true`.
     */
    open var isAutocompleteEnabled: Bool {
        autocompleteContext.isEnabled && !textDocumentProxy.isReadingFullDocumentContext
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
                let suggestions = try await autocompleteProvider.autocompleteSuggestions(for: text)
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
        autocompleteContext.reset()
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
            appGroupId: dictationContext.appGroupId ?? "",
            appDeepLink: dictationContext.appDeepLink ?? ""
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
                try await dictationService.startDictationFromKeyboard(with: dictationConfig)
            } catch {
                await MainActor.run {
                    dictationContext.lastError = error
                }
            }
        }
    }
}


// MARK: - Private Functions

private extension KeyboardInputViewController {

    func refreshProperties() {
        refreshCalloutActionContext()
    }

    func refreshCalloutActionContext() {
        calloutContext.actionContext = .init(
            actionHandler: keyboardActionHandler,
            actionProvider: calloutActionProvider
        )
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
        keyboardContext.$locale.sink { [weak self] in
            guard let self = self else { return }
            let locale = $0
            self.primaryLanguage = locale.identifier
            self.autocompleteProvider.locale = locale
        }.store(in: &cancellables)
    }

    func tryChangeToPreferredKeyboardTypeAfterTextDidChange() {
        let shouldSwitch = keyboardBehavior.shouldSwitchToPreferredKeyboardTypeAfterTextDidChange()
        guard shouldSwitch else { return }
        setKeyboardType(keyboardContext.preferredKeyboardType)
    }

    /// Update the autocomplete context with an error.
    func updateAutocompleteContext(with error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.autocompleteContext.lastError = error
        }
    }
    
    /// Update the autocomplete context with new suggestions.
    func updateAutocompleteContext(with result: [Autocomplete.Suggestion]) {
        DispatchQueue.main.async { [weak self] in
            self?.autocompleteContext.suggestions = result
        }
    }
}

public extension View {
    
    func withEnvironment(from controller: KeyboardInputViewController) -> some View {
        self.environmentObject(controller.autocompleteContext)
            .environmentObject(controller.calloutContext)
            .environmentObject(controller.dictationContext)
            .environmentObject(controller.keyboardContext)
            .environmentObject(controller.keyboardFeedbackSettings)
            .environmentObject(controller.keyboardTextContext)
    }
}
#endif

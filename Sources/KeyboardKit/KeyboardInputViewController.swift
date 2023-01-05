//
//  KeyboardViewController.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-03-13.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import Combine
import SwiftUI
import UIKit

/**
 This class extends `UIInputViewController` with KeyboardKit
 specific functionality.
 */
open class KeyboardInputViewController: UIInputViewController {
    
    
    // MARK: - View Controller Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        Self.shared = self
        setupInitialWidth()
        setupLocaleObservation()
        viewWillSetupKeyboard()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardContext.sync(with: self)
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        keyboardContext.syncAfterLayout(with: self)
    }

    /**
     This function is called whenever the keyboard should be
     created or updated.
     */
    open func viewWillSetupKeyboard() {
        // Override and implement your keyboard setup logic.
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        keyboardContext.sync(with: self)
        super.traitCollectionDidChange(previousTraitCollection)
    }
    
    
    // MARK: - Setup

    /**
     Setup KeyboardKit with a SwiftUI view.

     This function removes all views from the controller and
     adds the provided view in a way that the extension will
     resize to fit it. It also injects observable objects as
     `@EnvironmentObject` into the view hierarchy.
     */
    open func setup<Content: View>(with view: Content) {
        self.view.subviews.forEach { $0.removeFromSuperview() }
        let view = KeyboardRootView(view)
            .environmentObject(autocompleteContext)
            .environmentObject(actionCalloutContext)
            .environmentObject(inputCalloutContext)
            .environmentObject(keyboardContext)
            .environmentObject(keyboardFeedbackSettings)
        let host = KeyboardHostingController(rootView: view)
        host.add(to: self)
    }
    
    
    // MARK: - Combine
    
    var cancellables = Set<AnyCancellable>()
    
    
    
    // MARK: - Properties
    
    /**
     This internal property always returns the original text
     document proxy, regardless of if another proxy is set.
     */
    var originalTextDocumentProxy: UITextDocumentProxy {
        super.textDocumentProxy
    }
    
    /**
     The shared input view controller. This is registered as
     the keyboard extension is started.
     */
    public static var shared = KeyboardInputViewController()

    /**
     The text document proxy to use, which can either be the
     original text input proxy or the ``textInputProxy``, if
     it is set to a custom value.
     */
    open override var textDocumentProxy: UITextDocumentProxy {
        textInputProxy ?? originalTextDocumentProxy
    }
    
    /**
     A custom text input proxy to which text input should be
     redirected instead of the `textDocumentProxy`.
     
     If you want to modify this proxy, you can override this
     property and apply another `didSet`.
     */
    public var textInputProxy: TextInputProxy? {
        didSet { keyboardContext.sync(with: self) }
    }
    
    
    // MARK: - Observables
    
    /**
     The default, observable action callout context.
     
     This is used as global state for the callouts that show
     alternate actions for a long-pressed input key.
     */
    public lazy var actionCalloutContext = ActionCalloutContext(
        actionHandler: keyboardActionHandler,
        actionProvider: calloutActionProvider)
    
    /**
     The default, observable autocomplete context.
     
     This context is used as global state for the keyboard's
     autocomplete, e.g. the current suggestions.
     */
    public lazy var autocompleteContext = AutocompleteContext()
    
    /**
     The default, observable input callout context.
     
     This is used as global state for the callouts that show
     the currently typed character.
     */
    public lazy var inputCalloutContext = InputCalloutContext(
        isEnabled: UIDevice.current.userInterfaceIdiom == .phone)
    
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
    
    
    
    // MARK: - Services
    
    /**
     This provider is used to provide the keyboard extension
     with autocomplete suggestions.
     
     You can replace this instance with a custom instance. A
     disabled provider is used by default.
     */
    public lazy var autocompleteProvider: AutocompleteProvider = DisabledAutocompleteProvider()
    
    /**
     This provider is used to get a callout actions when the
     user long presses an input key.
     
     You can replace this instance with a custom instance. A
     ``StandardCalloutActionProvider`` is used by default.
     */
    public lazy var calloutActionProvider: CalloutActionProvider = StandardCalloutActionProvider(
        keyboardContext: keyboardContext) {
        didSet { refreshProperties() }  // TODO: Remove
    }
    
    /**
     This provider is used to get an input set, that is used
     to generate a complete keyboard layout.
     
     You can replace this instance with a custom instance. A
     ``StandardInputSetProvider`` is used by default.
     */
    public lazy var inputSetProvider: InputSetProvider = StandardInputSetProvider(
        keyboardContext: keyboardContext
    ) {
        didSet { refreshProperties() }
    }
    
    /**
     This action handler is used to handle actions that will
     be triggered when the keyboard is being.
     
     You can replace this instance with a custom instance. A
     ``StandardKeyboardActionHandler`` is used by default.
     */
    public lazy var keyboardActionHandler: KeyboardActionHandler = StandardKeyboardActionHandler(
        inputViewController: self) {
        didSet { refreshProperties() }
    }

    /**
     This appearance can be used to customize the keyboard's
     design, such as its colors, fonts etc.
     
     You can replace this instance with a custom instance. A
     ``StandardKeyboardAppearance`` is used by default.
     */
    public lazy var keyboardAppearance: KeyboardAppearance = StandardKeyboardAppearance(
        keyboardContext: keyboardContext)

    /**
     This behavior determines how the keyboard should behave
     when when the keyboard is being used.
     
     You can replace this instance with a custom instance. A
     ``StandardKeyboardBehavior`` is used by default.
     */
    public lazy var keyboardBehavior: KeyboardBehavior = StandardKeyboardBehavior(
        keyboardContext: keyboardContext)
    
    /**
     This feedback handler is used to setup audio and haptic
     feedback when the keyboard is being used.
     
     You can replace this instance with a custom instance. A
     ``StandardKeyboardFeedbackHandler`` is used by default.
     
     If you replace this instance with a custom instance, it
     is very important to update the ``keyboardActionHandler``
     as well, or to setup the custom instance before you use
     the action handler for the first time.
     */
    public lazy var keyboardFeedbackHandler: KeyboardFeedbackHandler = StandardKeyboardFeedbackHandler(
        settings: keyboardFeedbackSettings)
                    
    /**
     This provider is used to get a complete keyboard layout
     for the current ``keyboardContext``. This layout is the
     complete set of keys in a keyboard.
     
     You can replace this instance with a custom instance. A
     ``StandardKeyboardLayoutProvider`` is used by default.
     */
    public lazy var keyboardLayoutProvider: KeyboardLayoutProvider = StandardKeyboardLayoutProvider(
        keyboardContext: keyboardContext,
        inputSetProvider: inputSetProvider)
    
    
    
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
        tryChangeToPreferredKeyboardTypeAfterTextDidChange()
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
     Perform an autocomplete operation.
     
     You can override this function to extend or replace the
     default logic. By default, it uses the `currentWord` of
     the ``textDocumentProxy`` to perform autocomplete using
     the current ``autocompleteProvider``.
     */
    open func performAutocomplete() {
        guard let text = autocompleteText else { return resetAutocomplete() }
        autocompleteProvider.autocompleteSuggestions(for: text) { [weak self] result in
            self?.updateAutocompleteContext(with: result)
        }
    }
    
    /**
     Reset the current autocomplete state.
     
     You can override this function to extend or replace the
     default logic. By default, it resets the suggestions in
     the ``autocompleteContext``.
     */
    open func resetAutocomplete() {
        autocompleteContext.suggestions = []
    }
}


// MARK: - Private Functions

private extension KeyboardInputViewController {

    func refreshCalloutActionContext() {
        actionCalloutContext = ActionCalloutContext(
            actionHandler: keyboardActionHandler,
            actionProvider: calloutActionProvider)
    }
    
    func refreshProperties() {
        refreshLayoutProvider()
        refreshCalloutActionContext()
    }
    
    func refreshLayoutProvider() {
        keyboardLayoutProvider.register(
            inputSetProvider: inputSetProvider)
    }
    
    /**
     Make sure that the controller view is setup to at least
     have a standard width that isn't non-zero, to avoid bad
     view layout in SwiftUI.
     */
    func setupInitialWidth() {
        view.frame.size.width = UIScreen.main.bounds.width
    }
    
    /**
     Observe any changes to the context locale, which should
     trigger some locale-specific changes..
     */
    func setupLocaleObservation() {
        keyboardContext.$locale.sink { [weak self] in
            guard let self = self else { return }
            let locale = $0
            self.autocompleteProvider.locale = locale
        }.store(in: &cancellables)
    }
    
    func tryChangeToPreferredKeyboardTypeAfterTextDidChange() {
        let context = keyboardContext
        let shouldSwitch = keyboardBehavior.shouldSwitchToPreferredKeyboardTypeAfterTextDidChange()
        guard shouldSwitch else { return }
        keyboardContext.keyboardType = context.preferredKeyboardType
    }

    /**
     Update the autocomplete context with a certain result.

     This is performed async to avoid that any network-based
     operations update the context from a background thread.
     */
    func updateAutocompleteContext(with result: AutocompleteResult) {
        DispatchQueue.main.async { [weak self] in
            guard let context = self?.autocompleteContext else { return }
            switch result {
            case .failure(let error): context.lastError = error
            case .success(let result): context.suggestions = result
            }
        }
    }
}
#endif

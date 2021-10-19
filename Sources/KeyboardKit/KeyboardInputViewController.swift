//
//  KeyboardViewController.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-03-13.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

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
        setupLocaleObservation()
        viewWillSetupKeyboard()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardContext.sync(with: self)
    }
    
    open override func viewWillLayoutSubviews() {
        keyboardContext.sync(with: self)
        super.viewWillLayoutSubviews()
    }
    
    open func viewWillSetupKeyboard() {
        // Override and implement your keyboard setup logic.
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        keyboardContext.sync(with: self)
        super.traitCollectionDidChange(previousTraitCollection)
    }
    
    
    // MARK: - Root View
    
    /**
     This view is used as a wrapper view, to be able to bind
     the keyboard view to properties that affect your layout
     without triggering a view update.
     */
    private struct RootView<ViewType: View>: View {
        
        init(_ view: ViewType) {
            self.view = view
        }
        
        var view: ViewType
        
        @EnvironmentObject private var context: KeyboardContext
        
        var body: some View {
            view.id("\(context.locale)\(context.screenOrientation.isLandscape)")
        }
    }
    
    
    // MARK: - Setup

    /**
     Setup KeyboardKit with a SwiftUI `View`.
     
     This will remove all subviews, then add the view pinned
     to the edges of its view, so that the extension resizes
     to fit its content.
     
     This will also inject the input controller's observable
     objects as `@EnvironmentObject`s into the view hiearchy.
     */
    open func setup<Content: View>(with view: Content) {
        self.view.subviews.forEach { $0.removeFromSuperview() }
        let view = RootView(view)
            .environmentObject(autocompleteContext)
            .environmentObject(keyboardContext)
            .environmentObject(keyboardFeedbackSettings)
            .environmentObject(keyboardInputCalloutContext)
            .environmentObject(keyboardSecondaryInputCalloutContext)
        let host = KeyboardHostingController(rootView: view)
        host.add(to: self)
    }
    
    
    // MARK: - Combine
    
    var cancellables = Set<AnyCancellable>()
    
    
    
    // MARK: - Properties
    
    /**
     Get the bundle id of the currently active app, that was
     used to initialize the keyboard extension.
     */
    public var activeAppBundleId: String? {
        parent?.value(forKey: "_hostBundleID") as? String
    }
    
    /**
     Set this property to either `true` or `false` to ignore
     the real `needsInputModeSwitchKey` value.
     
     This can be used to avoid warnings when previeweing etc.
     */
    public static var needsInputModeSwitchKeyOverride: Bool?
    
    /**
     Set this property to either `true` or `false` to ignore
     the real `needsInputModeSwitchKey` value.
     
     This can be used to avoid warnings when previeweing etc.
     */
    public lazy var needsInputModeSwitchKeyOverride: Bool? = {
        Self.needsInputModeSwitchKeyOverride
    }()
    
    /**
     Whether or not the keyboards needs a "globe" button for
     switching keyboard.
     */
    open override var needsInputModeSwitchKey: Bool {
        needsInputModeSwitchKeyOverride ?? super.needsInputModeSwitchKey
    }
    
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
     A proxy to the text input object with which this custom
     keyboard is interacting with.
     
     If you set `textInputProxy` to a custom object, it will
     be used instead of the real text document proxy.
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
     The default, observable autocomplete context.
     
     This context is used as global state for the keyboard's
     autocomplete, e.g. the current suggestions.
     */
    public lazy var autocompleteContext = AutocompleteContext()
    
    /**
     The default, observable keyboard context.
     
     This context is used as global state for the keyboard's
     overall state and configuration like the current locale,
     device, screen etc.
     */
    public lazy var keyboardContext = KeyboardContext(controller: self)
    
    /**
     The default, observable feedback settings.
     
     This property is used as a global configuration for the
     keyboard's feedback, e.g. audio and haptic feedback.
     */
    public lazy var keyboardFeedbackSettings = KeyboardFeedbackSettings()
    
    /**
     The default, observable input callout context.
     
     This context is used as global state for the keyboard's
     input callout, which shows the currently typed char.
     */
    public lazy var keyboardInputCalloutContext = InputCalloutContext(
        isEnabled: UIDevice.current.userInterfaceIdiom == .phone)
    
    /**
     The default, observable secondary input callout context.
     
     This context is used as global state for the keyboard's
     secondary input action callout, which shows a secondary
     callout with actions for a long-pressed input key.
     */
    public lazy var keyboardSecondaryInputCalloutContext = SecondaryInputCalloutContext(
        actionHandler: keyboardActionHandler,
        actionProvider: keyboardSecondaryCalloutActionProvider)
    
    
    
    // MARK: - Services
    
    /**
     This provider is used to provide the keyboard extension
     with autocomplete suggestions.
     
     You can replace this instance with a custom instance. A
     ``DisabledAutocompleteProvider`` is used by default.
     */
    public lazy var autocompleteProvider: AutocompleteProvider = DisabledAutocompleteProvider()
    
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
        context: keyboardContext)

    /**
     This behavior determines how the keyboard should behave
     when when the keyboard is being used.
     
     You can replace this instance with a custom instance. A
     ``StandardKeyboardBehavior`` is used by default.
     */
    public lazy var keyboardBehavior: KeyboardBehavior = StandardKeyboardBehavior(
        context: keyboardContext)
    
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
     This provider is used to get input keys for the current
     ``keyboardContext``. These keys will be used to make up
     the complete keyboard layout.
     
     You can replace this instance with a custom instance. A
     ``StandardKeyboardInputSetProvider`` is used by default.
     */
    public lazy var keyboardInputSetProvider: KeyboardInputSetProvider = StandardKeyboardInputSetProvider(
        context: keyboardContext) {
        didSet { refreshProperties() }
    }
                    
    /**
     This provider is used to get a complete keyboard layout
     for the current ``keyboardContext``. This layout is the
     complete set of keys in a keyboard.
     
     You can replace this instance with a custom instance. A
     ``StandardKeyboardLayoutProvider`` is used by default.
     */
    public lazy var keyboardLayoutProvider: KeyboardLayoutProvider = StandardKeyboardLayoutProvider(
        inputSetProvider: keyboardInputSetProvider)
    
    /**
     This provider is used to get a secondary callout action
     collection for the current ``keyboardContext`` when the
     keyboard is being used.
     
     You can replace this instance with a custom instance. A
     ``StandardSecondaryCalloutActionProvider`` will be used
     by default.
     */
    public lazy var keyboardSecondaryCalloutActionProvider: SecondaryCalloutActionProvider = StandardSecondaryCalloutActionProvider(
        context: keyboardContext) {
        didSet { refreshProperties() }
    }
    
    
    
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
        keyboardContext.textDocumentProxy = textDocumentProxy
    }
    
    open override func textDidChange(_ textInput: UITextInput?) {
        super.textDidChange(textInput)
        performAutocomplete()
        tryChangeToPreferredKeyboardTypeAfterTextDidChange()
    }
    
    
    
    // MARK: - Autocomplete
    
    /**
     Perform an autocomplete operation.
     
     You can override this function to extend or replace the
     default logic. By default, it uses the `currentWord` of
     the ``textDocumentProxy`` to perform autocomplete using
     the current ``autocompleteProvider``.
     */
    open func performAutocomplete() {
        guard let word = textDocumentProxy.currentWord else { return resetAutocomplete() }
        autocompleteProvider.autocompleteSuggestions(for: word) { [weak self] result in
            switch result {
            case .failure(let error): print(error.localizedDescription)
            case .success(let result): self?.autocompleteContext.suggestions = result
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
        autocompleteContext.suggestions = []
    }
}


// MARK: - Private Functions

private extension KeyboardInputViewController {
    
    func refreshProperties() {
        refreshLayoutProvider()
        refreshSecondaryInputCalloutContext()
    }
    
    func refreshLayoutProvider() {
        keyboardLayoutProvider.register(
            inputSetProvider: keyboardInputSetProvider)
    }
    
    func refreshSecondaryInputCalloutContext() {
        keyboardSecondaryInputCalloutContext = SecondaryInputCalloutContext(
            actionHandler: keyboardActionHandler,
            actionProvider: keyboardSecondaryCalloutActionProvider)
    }
    
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
}

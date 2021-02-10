//
//  KeyboardViewController.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-03-13.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI
import UIKit

/**
 This class extends `UIInputViewController` with KeyboardKit
 specific functionality.
 
 With KeyboardKit, let your `KeyboardViewController` inherit
 this class instead of `UIInputViewController`. You then get
 access to a bunch of features that regular controllers lack.
 
 To customize the keyboard setup, override `setupKeyboard`.
 
 To change the keyboard type and automatically setup the new
 keyboard, set the `keyboardType` property of this class and
 not of its context. You can also call `changeKeyboardType()`
 which can be overridden and customized.
 
 To setup autocomplete, simply override `performAutocomplete`
 and `resetAutocomplete`. They are automatically called when
 the texst position changes or the action handler performs a
 keyboard action.
 */
open class KeyboardInputViewController: UIInputViewController {
    
    
    // MARK: - View Controller Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        Self.shared = self
        setupKeyboard()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardContext.sync(with: self)
        viewWillSyncWithTextDocumentProxy()
    }
    
    open override func viewWillLayoutSubviews() {
        keyboardContext.sync(with: self)
        super.viewWillLayoutSubviews()
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        keyboardContext.sync(with: self)
        super.traitCollectionDidChange(previousTraitCollection)
    }
    
    open func viewWillSyncWithTextDocumentProxy() {
        keyboardContext.textDocumentProxy = textDocumentProxy
    }
    
    
    // MARK: - Setup

    /**
     Remove all subviews from the vc view and add a `SwiftUI`
     view to it. This will pin the view to the edges of this
     extension and will resize the extension to fit the view.
     
     This function also applies `@EnvironmentObject`s to the
     view, that can be used by all nested views.
     */
    open func setup<Content: View>(with view: Content) {
        self.view.subviews.forEach { $0.removeFromSuperview() }
        let view = view
            .environmentObject(autocompleteContext)
            .environmentObject(keyboardContext)
            .environmentObject(keyboardInputCalloutContext)
            .environmentObject(keyboardSecondaryInputCalloutContext)
        let controller = KeyboardHostingController(rootView: view)
        controller.add(to: self)
    }
    
    
    // MARK: - Properties
    
    /**
     The shared input view controller. This is registered as
     the keyboard extension is started.
     */
    public static var shared: KeyboardInputViewController!
    
    /**
     The extension's default keyboard context.
     */
    public lazy var autocompleteContext = ObservableAutocompleteContext()
    
    /**
     The extension's default keyboard action handler.
     */
    public lazy var keyboardActionHandler: KeyboardActionHandler = StandardKeyboardActionHandler(
        inputViewController: self)

    /**
     The extension's default keyboard appearance.
     */
    public lazy var keyboardAppearance: KeyboardAppearance = StandardKeyboardAppearance(
        context: keyboardContext)

    /**
     The extension's default keyboard behavior.
     */
    public lazy var keyboardBehavior: KeyboardBehavior = StandardKeyboardBehavior(
        context: keyboardContext)
    
    /**
     The extension's default keyboard context.
     */
    public lazy var keyboardContext = ObservableKeyboardContext(controller: self)
    
    /**
     The extension's default input callout context.
     */
    public lazy var keyboardInputCalloutContext = InputCalloutContext()
    
    /**
     The extension's default keyboard input set provider.
     */
    public lazy var keyboardInputSetProvider: KeyboardInputSetProvider = StandardKeyboardInputSetProvider(
        context: keyboardContext)
                    
    /**
     The extension's default keyboard layout provider.
     */
    public lazy var keyboardLayoutProvider: KeyboardLayoutProvider = StandardKeyboardLayoutProvider(
        inputSetProvider: keyboardInputSetProvider)
    
    /**
     The extension's default secondary input action provider.
     */
    public lazy var keyboardSecondaryCalloutActionProvider: SecondaryCalloutActionProvider = StandardSecondaryCalloutActionProvider(
        context: keyboardContext)
    
    /**
     The extension's default secondary input callout context.
     */
    public lazy var keyboardSecondaryInputCalloutContext = SecondaryInputCalloutContext(
        actionProvider: keyboardSecondaryCalloutActionProvider,
        actionHandler: keyboardActionHandler)
    
    /**
     The keyboard type that is currently used by the context.
     
     Setting this value will update the context's type, then
     call `setupKeyboard`.
     */
    public var keyboardType: KeyboardType {
        get { keyboardContext.keyboardType }
        set {
            keyboardContext.keyboardType = newValue
            setupKeyboard()
        }
    }
    
    
    // MARK: - View Properties
    
    /**
     This is a regular, vertical `UIStackView`, to which you
     can add toolbars, rows etc. to create `UIKit` keyboards.
     */
    public lazy var keyboardStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        view.addSubview(stackView, fill: true)
        return stackView
    }()
    
    
    // MARK: - Text And Selection Change
    
    /**
     Setup the keyboard, given the current state of your app.
     
     You can override this function to implement how a setup
     should behave in your app. This does nothing by default.
     */
    open func setupKeyboard() {}
    
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
    
    
    // MARK: - Public Functions
    
    /**
     Change the keyboard locale.
     
     This function can be called directly or injected into a
     nested service class to avoid bilinear dependencies.
     */
    open func changeKeyboardLocale(to locale: Locale) {
        primaryLanguage = locale.languageCode
        keyboardContext.locale = locale
    }
    
    /**
     Change the keyboard type.
     
     This function can be called directly or injected into a
     nested service class to avoid bilinear dependencies.
     */
    open func changeKeyboardType(to type: KeyboardType) {
        keyboardType = type
    }
    
    /**
     Perform an autocomplete operation. You can override the
     function to provide custom autocomplete logic.
     */
    open func performAutocomplete() {}
    
    /**
     Reset autocomplete state. You can override the function
     to provide custom autocomplete logic.
     */
    open func resetAutocomplete() {}
}


// MARK: - Private Functions

private extension KeyboardInputViewController {
    
    func tryChangeToPreferredKeyboardTypeAfterTextDidChange() {
        let context = keyboardContext
        let shouldSwitch = keyboardBehavior.shouldSwitchToPreferredKeyboardTypeAfterTextDidChange()
        guard shouldSwitch else { return }
        changeKeyboardType(to: context.preferredKeyboardType)
    }
}

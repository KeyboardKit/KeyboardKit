//
//  KeyboardViewController.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-03-13.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

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
    
    /**
     This calls the super class implementation, then sets up
     the keyboard by calling `setupKeyboard`.
     */
    open override func viewDidLoad() {
        super.viewDidLoad()
        Self.shared = self
        setupKeyboard()
    }
    
    /**
     This calls the super class implementation then performs
     a full context syncs.
     */
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardContext.sync(with: self)
        viewWillSyncWithTextDocumentProxy()
    }
    
    /**
     This calls the super class implementation, then updates
     some `context` properties.
     */
    open override func viewWillLayoutSubviews() {
        keyboardContext.hasDictationKey = hasDictationKey
        keyboardContext.needsInputModeSwitchKey = needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }
    
    /**
     This function is called when this controller appears or
     when the text document proxy changes.
     */
    open func viewWillSyncWithTextDocumentProxy() {
        keyboardContext.textDocumentProxy = textDocumentProxy
    }
    
    
    // MARK: - Properties
    
    /**
     The shared input view controller. This is registered as
     the keyboard extension is started.
     */
    public static var shared: KeyboardInputViewController!
    
    /**
     The extension's default keyboard action handler.
     */
    public lazy var keyboardActionHandler: KeyboardActionHandler = StandardKeyboardActionHandler(
        keyboardContext: keyboardContext,
        keyboardBehavior: keyboardBehavior,
        autocompleteAction: performAutocomplete,
        changeKeyboardTypeAction: changeKeyboardType)

    /**
     The extension's default keyboard appearance.
     */
    public lazy var keyboardAppearance: KeyboardAppearance = StandardKeyboardAppearance(
        context: keyboardContext)

    /**
     The extension's default keyboard behavior.
     */
    public lazy var keyboardBehavior: KeyboardBehavior = StandardKeyboardBehavior()
    
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
    public lazy var keyboardInputSetProvider: KeyboardInputSetProvider = StandardKeyboardInputSetProvider()
                    
    /**
     The extension's default keyboard layout provider.
     */
    public lazy var keyboardLayoutProvider: KeyboardLayoutProvider = StandardKeyboardLayoutProvider(
        inputSetProvider: keyboardInputSetProvider)
    
    /**
     The extension's default secondary input callout context.
     */
    public lazy var keyboardSecondaryInputActionProvider: SecondaryCalloutActionProvider = StandardSecondaryCalloutActionProvider(
        context: keyboardContext)
    
    /**
     The extension's default secondary input callout context.
     */
    public lazy var keyboardSecondaryInputCalloutContext = SecondaryInputCalloutContext(
        context: keyboardContext,
        actionProvider: keyboardSecondaryInputActionProvider,
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
    
    
    // MARK: - Keyboard Functionality
    
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
    
    
    // MARK: - Public Functions
    
    /**
     Change keyboard type. By default, this is done with the
     standard change action of the current context, but this
     can be changed by overriding this function.
     */
    open func changeKeyboardType(to type: KeyboardType) {
        keyboardType = type
    }
    
    
    // MARK: - Autocomplete
    
    open func performAutocomplete() {}
    
    open func resetAutocomplete() {}
    
    
    // MARK: - UITextInputDelegate
    
    open override func textWillChange(_ textInput: UITextInput?) {
        super.textWillChange(textInput)
        viewWillSyncWithTextDocumentProxy()
    }
    
    open override func textDidChange(_ textInput: UITextInput?) {
        super.textDidChange(textInput)
        performAutocomplete()
        tryChangeToPreferredKeyboardTypeAfterTextDidChange()
    }
}


// MARK: - Private Functions

private extension KeyboardInputViewController {
    
    func tryChangeToPreferredKeyboardTypeAfterTextDidChange() {
        let context = keyboardContext
        let shouldSwitch = keyboardBehavior.shouldSwitchToPreferredKeyboardTypeAfterTextDidChange(for: context)
        guard shouldSwitch else { return }
        changeKeyboardType(to: context.preferredKeyboardType)
    }
}

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
 specific properties and functionality.
 
 When you use KeyboardKit, let your `KeyboardViewController`
 inherit this class instead of `UIInputViewController`. This
 will provide it with a bunch of features that regular input
 view controllers lack.
 
 If your keyboard extension should use autocomplete, you can
 override `performAutocomplete` and `resetAutocomplete`. The
 two functions are called by `StandardKeyboardActionHandler`
 and this class whenever a new autocomplete operation should
 be performed or the current suggestions should be reset.
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
     The keyboard action handler used by the extension.
     */
    public lazy var keyboardActionHandler: KeyboardActionHandler = StandardKeyboardActionHandler(
        inputViewController: self,
        behavior: keyboardBehavior)

    /**
     The keyboard appearance used by the extension.
     */
    public lazy var keyboardAppearance: KeyboardAppearance = StandardKeyboardAppearance()

    /**
     The keyboard behavior used by the extension.
     */
    public lazy var keyboardBehavior: KeyboardBehavior = StandardKeyboardBehavior()
    
    /**
     This context provides keyboard-specific information.
     */
    public lazy var keyboardContext = ObservableKeyboardContext(
        controller: self,
        actionHandler: keyboardActionHandler,
        keyboardType: .alphabetic(.lowercased))
                    
    /**
     The keyboard layout provider used by the extension.
     */
    public lazy var keyboardLayoutProvider: KeyboardLayoutProvider = StandardKeyboardLayoutProvider()
    
    
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
        keyboardContext.keyboardType = type
        setupKeyboard()
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

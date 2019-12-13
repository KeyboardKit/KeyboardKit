//
//  KeyboardViewController.swift
//  KeyboardKit
//
//  Created by Dainel Saidi on 2018-03-13.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This class provides keyboards input view controllers with a
 basic set of functionality. You can subclass this class and
 override anything to modify the standard behavior.
 
 * Use `keyboardActionHandler` to handle keyboard actions.
 * Use `keyboardStackView` to setup and populate a keyboard.
 * Use `addKeyboardGestures(to:)` to add keyboard gestures.
 */
open class KeyboardInputViewController: UIInputViewController {

    
    // MARK: - View Controller Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(keyboardStackView, fill: true)
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillSyncWithTextDocumentProxy()
    }
    
    /**
     This function is called when this controller appears or
     the text document proxy text changes. You can use it to
     apply a style that matches the proxy configuration.
     */
    open func viewWillSyncWithTextDocumentProxy() {}
    
    
    // MARK: - Properties
    
    /**
     The `keyboardActionHandler` can handle keyboard actions
     that are triggered by the user. If you do not specify a
     custom action handler, a `StandardKeyboardActionHandler`
     instance will be used by default.
     */
    open lazy var keyboardActionHandler: KeyboardActionHandler = {
        StandardKeyboardActionHandler(inputViewController: self)
    }()
    
    
    // MARK: - View Properties
    
    /**
     `keyboardStackView` is a regular `UIStackView` to which
     you can add any views and configure in any way you like.
     
     If you use `KeyboardStackViewComponent` when populating
     this view, the stack view will be resized in a way that
     also resizes the keyboard extension.
     */
    public lazy var keyboardStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    
    // MARK: - Public Functions
    
    open func addKeyboardGestures(to button: KeyboardButton) {
        button.removeTapAction()
        button.removeLongPressAction()
        button.removeRepeatingAction()
        if button.action == .switchKeyboard { return addSwitchKeyboardGesture(to: button) }
        addTapGesture(to: button)
        addLongPressGesture(to: button)
        addRepeatingGesture(to: button)
    }
    
    
    // MARK: - UITextInputDelegate
    
    open override func textWillChange(_ textInput: UITextInput?) {
        super.textWillChange(textInput)
        viewWillSyncWithTextDocumentProxy()
    }
}


// MARK: - Private Functions

private extension KeyboardInputViewController {
    
    func addSwitchKeyboardGesture(to button: KeyboardButton) {
        guard let button = button as? UIButton else { return }
        button.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
    }
    
    func addLongPressGesture(to button: KeyboardButton) {
        button.addLongPressAction { [weak self] in
            let handler = self?.keyboardActionHandler
            handler?.handleLongPress(on: button.action, view: button)
        }
    }
    
    func addRepeatingGesture(to button: KeyboardButton) {
        button.addRepeatingAction { [weak self] in
            let handler = self?.keyboardActionHandler
            handler?.handleRepeat(on: button.action, view: button)
        }
    }
    
    func addTapGesture(to button: KeyboardButton) {
        button.addTapAction { [weak self] in
            let handler = self?.keyboardActionHandler
            handler?.handleTap(on: button.action, view: button)
        }
    }
}

//
//  KeyboardViewController.swift
//  KeyboardKit
//
//  Created by Dainel Saidi on 2018-03-13.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This class provides keyboards input view controllers with a
 basic set of functionality. You can subclass this class and
 override anything to modify the standard behavior.
 
 The class has a `keyboardActionHandler` to which you should
 delegate all triggered keyboard actions. It uses a standard
 `StandardKeyboardActionHandler` by default, but you can set
 `keyboardActionHandler` to any `KeyboardActionHandler`.
 
 To apply standard gestures to a keyboard button, simply use
 `addKeyboardGestures(to:)`.
 
 `viewWillSyncWithTextDocumentProxy()` is triggered when the
 view controller will appear or when the text document proxy
 text changes. Use this to apply any style you think matches
 the text document proxy configuration.
 
 `keyboardStackView` is a regular `UIStackView` to which you
 can add any views and configure in any way you like. If you
 add `KeyboardStackViewComponent`s to it, however, they will
 make sure the stack view is properly resized, in a way that
 also resizes the keyboard extension.
 
 */

import UIKit

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
    
    open func viewWillSyncWithTextDocumentProxy() {}
    
    
    // MARK: - Properties
    
    open lazy var keyboardActionHandler: KeyboardActionHandler = {
        StandardKeyboardActionHandler(inputViewController: self)
    }()
    
    
    // MARK: - View Properties
    
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

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
 
 The class uses an actionless keyboard and a standard action
 handler by default. You can replace them at any time.
 
 `viewWillSyncWithTextDocumentProxy()` is triggered when the
 view controller will appear or when the text document proxy
 text changes. Use this to apply any style you think matches
 the text document proxy configuration.
 
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
    
    open var id: String?
    
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
    
    func addKeyboardGestures(to button: KeyboardButton) {
        if button.action == .switchKeyboard { return addSwitchKeyboardGesture(to: button) }
        addTapGesture(to: button)
        addLongPressGesture(to: button)
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
        button.removeLongPressGestureRecognizers()
        button.addLongPressGestureRecognizer { [weak self] in
            self?.keyboardActionHandler.handleLongPress(on: button, action: button.action)
        }
    }
    
    func addTapGesture(to button: KeyboardButton) {
        button.removeTapGestureRecognizers()
        button.addTapGestureRecognizer { [weak self] in
            self?.keyboardActionHandler.handleTap(on: button, action: button.action)
        }
    }
}

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
 
 This class uses an action-less keyboard and standard action
 handler by default. You can replace these properties at any
 time, to customize the keyboard behavior.
 
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
    
    open var keyboard = Keyboard.empty
    
    open lazy var keyboardActionHandler: KeyboardActionHandler = {
        StandardKeyboardActionHandler(inputViewController: self)
    }()
    
    open lazy var keyboardPresenter: KeyboardPresenter = {
        NoneKeyboardPresenter()
    }()
    
    open var settings = StandardKeyboardSettings()
    
    
    // MARK: - View Properties
    
    public lazy var keyboardStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    
    // MARK: - UITextInputDelegate
    
    open override func textWillChange(_ textInput: UITextInput?) {
        super.textWillChange(textInput)
        viewWillSyncWithTextDocumentProxy()
    }
}

//
//  KeyboardViewController.swift
//  KeyboardKit
//
//  Created by Dainel Saidi on 2018-03-13.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This class extends `UIInputViewController` with KeyboardKit
 specific properties and functionality. You can subclass the
 class to modify any standard behavior.
 */
open class KeyboardInputViewController: UIInputViewController {

    
    // MARK: - View Controller Lifecycle
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillSyncWithTextDocumentProxy()
    }
    
    /**
     This function is called when this controller appears or
     when the text document proxy changes. You can use it to
     apply a style that matches the proxy configuration.
     */
    open func viewWillSyncWithTextDocumentProxy() {}
    
    
    // MARK: - Properties
    
    /**
     This handler can be used to handle any keyboard actions
     that are triggered by the user or the system.
     
     You can override this property with any custom keyboard
     action handler. If no custom action handler is set, the
     controller will use a `StandardKeyboardActionHandler`.
     */
    open lazy var keyboardActionHandler: KeyboardActionHandler = StandardKeyboardActionHandler(inputViewController: self)
    
    
    // MARK: - View Properties
    
    /**
     `keyboardStackView` is a regular `UIStackView` that you
     can configure freely and add any views you like to. Use
     it if you prefer to use `UIKit` to create your keyboard.
     
     This view will be added to the extension's view as soon
     as you use it. It will setup its constraints so that it
     resizes together with the extension.
     
     The standard axis is `vertical`, since the idea is that
     this view should be populated with `rows`, to which you
     can add toolbars, buttons etc.
     */
    public lazy var keyboardStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        view.addSubview(stackView, fill: true)
        return stackView
    }()
    
    
    // MARK: - Public Functions
    
    /**
     Add `tap`, `long press` and `repeat` gestures to a view
     that should serve as a keyboard button.
     */
    open func addKeyboardGestures(to button: KeyboardButton) {
        button.gestureRecognizers?.forEach { button.removeGestureRecognizer($0) }
        if button.action == .nextKeyboard { return addNextKeyboardGesture(to: button) }
        addStandardKeyboardGestures(to: button)
    }
    
    /**
     Setup any `UIButton` as a "next keyboard" button, which
     means that it will switch to the "next" system keyboard
     when tapped and display a keyboard list when pressed.
     */
    public func setupNextKeyboardButton(_ button: UIButton) {
        let action = #selector(handleInputModeList(from:with:))
        button.addTarget(self, action: action, for: .allTouchEvents)
    }
    
    
    // MARK: - UITextInputDelegate
    
    open override func textWillChange(_ textInput: UITextInput?) {
        super.textWillChange(textInput)
        viewWillSyncWithTextDocumentProxy()
    }
}

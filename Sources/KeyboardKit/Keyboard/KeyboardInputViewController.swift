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
 
 `keyboardActionHandler` can be used to handle any triggered
 keyboard actions. If you don't replace it with a custom one,
 a `StandardKeyboardActionHandler` one is used by default.
 
 `keyboardStackView` view is a lazy view that's added to the
 keyboard extension view only when it's first called. Use it
 if you prefer to use `UIKit` to build your extension.
 
 `addKeyboardGestures(to:)` it used to add keyboard gestures
 to keyboard buttons, e.g. `tap`, `long press` and `repeat`.
 These gestures are then forwarded to the action handler.
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
     
     A `StandardKeyboardActionHandler` instance will be used
     by default, if you don't apply a custom one.
     */
    open lazy var keyboardActionHandler: KeyboardActionHandler = StandardKeyboardActionHandler(inputViewController: self)
    
    
    // MARK: - View Properties
    
    /**
     `keyboardStackView` is a regular `UIStackView` that you
     can configure freely and add any views you like. Use it
     if you prefer to use `UIKit` to create your keyboard.
     
     The view will be added to the extension view as soon as
     you use. It will setup its constraints so that its size
     resizes the extension.
     
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
        button.removeTapAction()
        button.removeLongPressAction()
        button.removeRepeatingAction()
        if button.action == .switchKeyboard { return addSwitchKeyboardGesture(to: button) }
        addTapGesture(to: button)
        addLongPressGesture(to: button)
        addRepeatingGesture(to: button)
    }
    
    /**
     Setup any `UIButton` as a "next keyboard" button, which
     means that it will switch to the "next" system keyboard
     when tapped and display a keyboard list when pressed.
     */
    public func setupNextKeyboardButton(_ button: UIButton) {
        button.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
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

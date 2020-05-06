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
     The seconds delay that `changeKeyboardType` uses before
     changing the keyboard type.
     
     The delay is required when your keyboard has double tap
     support, since it require that buttons stay around long
     enough double taps to register. If you don't use double
     taps, you can set this property to `0`.
     */
    public var changeKeyboardTypeDelay: TimeInterval = 0.2
    
    /**
     This handler can be used to handle any keyboard actions
     that are triggered by the user or the system.
     
     You can override this property with any custom keyboard
     action handler. If no custom action handler is set, the
     controller will use a `StandardKeyboardActionHandler`.
     */
    open lazy var keyboardActionHandler: KeyboardActionHandler = StandardKeyboardActionHandler(inputViewController: self)
    
    /**
     This property can be used to handle which keyboard type
     that is currently displayed by the view controller. You
     can change this value by calling `changeKeyboardType()`,
     which will change this value, then call `setupKeyboard`.
     
     If you have a single keyboard type in your app, you can
     ignore this property.
     */
    open var keyboardType = KeyboardType.custom("") {
        didSet { setupKeyboard() }
    }
    
    /**
     Get the current device orientation. If no window can be
     resolved `portrait` is returned.
     */
    public var deviceOrientation: UIInterfaceOrientation {
        view.window?.screen.orientation ?? .portrait
    }
    
    
    // MARK: - View Properties
    
    /**
     `keyboardStackView` is a regular `UIStackView` that you
     can configure freely and add any views you like to. Use
     it if you prefer to use `UIKit` to create your keyboard.
     
     This view is added to the extension view as soon as you
     use it. It applies constraints so it fits the extension.
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
     Whether or not the input view controller can change its
     keyboard type to a new specific type.
     */
    open func canChangeKeyboardType(to type: KeyboardType) -> Bool {
        guard
            case .alphabetic(let state) = keyboardType,
            case .alphabetic(let newState) = type
            else { return true }
        if state == .capsLocked && newState == .uppercased { return false }
        return true
    }
    
    /**
     Change keyboard type. This sets `keyboardType` to `type`
     after `changeKeyboardTypeDelay` seconds, which triggers
     `setupKeyboard()` when set.
     */
    open func changeKeyboardType(to type: KeyboardType) {
        let delay = changeKeyboardTypeDelay
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            guard self.canChangeKeyboardType(to: type) else { return }
            self.keyboardType = type
        }
    }
    
    /**
     Setup any `UIButton` as a "next keyboard" system button.
     */
    public func setupNextKeyboardButton(_ button: UIButton) {
        let action = #selector(handleInputModeList(from:with:))
        button.addTarget(self, action: action, for: .allTouchEvents)
    }
    
    /**
     Setup the keyboard, given the current state of your app.
     
     You can override this function to implement how a setup
     should behave in your app. This does nothing by default.
     */
    open func setupKeyboard() {}
    
    
    // MARK: - UITextInputDelegate
    
    open override func textWillChange(_ textInput: UITextInput?) {
        super.textWillChange(textInput)
        viewWillSyncWithTextDocumentProxy()
    }
}

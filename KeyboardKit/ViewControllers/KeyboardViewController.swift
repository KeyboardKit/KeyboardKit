//
//  KeyboardViewController.swift
//  KeyboardKit
//
//  Created by Dainel Saidi on 2018-03-13.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This base class provides keyboards with basic functionality.
 You can subclass this class then override anything you want
 to modify the standard behavior.
 
 This class will use an empty keyboard and a standard action
 handler by default. You can replace these properties at any
 time, to customize the keyboard behavior.
 
 Call `setHeight(to:)` to change the height of the keyboard,
 e.g. when the number of buttons or the orientation changes.
 
 Use `addTapGesture(to:)` and `addLongPressGesture(to:)`, to
 add keyboard gestures to any buttons you may create in your
 keyboard extensions. By default, this class does not create
 any buttons; it just holds the state of the keyboard.
 
 */

import UIKit

open class KeyboardViewController: UIInputViewController, KeyboardPresenter {
    
    
    // MARK: - Properties
    
    open var id: String?
    
    open var keyboard = Keyboard.empty
    
    open lazy var keyboardActionHandler: KeyboardActionHandler = {
        StandardKeyboardActionHandler(inputViewController: self, textDocumentProxy: textDocumentProxy)
    }()
    
    private var heightConstraint: NSLayoutConstraint?
    
    
    // MARK: - Public Functions
    
    open func addLongPressGesture(to cell: UIView, with action: KeyboardAction) {
        let gestures = cell.gestureRecognizers ?? []
        let longPresses = gestures.filter { $0 is UILongPressGestureRecognizer }
        longPresses.forEach { cell.removeGestureRecognizer($0) }
        cell.addLongPressGestureRecognizer { [weak self] in
            self?.keyboardActionHandler.handleLongPress(on: action)
        }
    }
    
    open func setHeight(to height: CGFloat) {
        heightConstraint?.constant = height
        if heightConstraint != nil { return }
        let constraint = NSLayoutConstraint.attribute(.height, in: view, constant: height)
        constraint.priority = .required
        constraint.isActive = true
        view.addConstraint(constraint)
        heightConstraint = constraint
    }
}

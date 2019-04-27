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
 
 `addTapGesture(for:to:)` and `addLongPressGesture(for:to:)`
 can be used to add action gestures to button views that you
 add to your keyboard extensions. They will send any actions
 that the user triggers to the action handler.
 
 `setHeight(to:)` can be used to to change the height of the
 keyboard extension. Do not use this whenever you use a grid
 based keyboard, since this class will automatically set the
 extension height based on the grid.
 
 */

import UIKit

open class KeyboardViewController: UIInputViewController {
    
    
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
    
    private var heightConstraint: NSLayoutConstraint?
    
    
    // MARK: - Public Functions
    
    open func addLongPressGesture(for action: KeyboardAction, to view: UIView) {
        view.removeLongPressGestureRecognizers()
        view.addLongPressGestureRecognizer { [weak self] in
            self?.keyboardActionHandler.handleLongPress(on: action)
        }
    }
    
    open func addTapGesture(for action: KeyboardAction, to view: UIView) {
        view.removeTapGestureRecognizers()
        view.addTapGestureRecognizer { [weak self] in
            self?.keyboardActionHandler.handleTap(on: action)
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

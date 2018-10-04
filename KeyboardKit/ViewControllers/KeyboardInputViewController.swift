//
//  KeyboardInputViewController.swift
//  KeyboardKit
//
//  Created by Dainel Saidi on 2018-03-13.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This base class provides KeyboardKit keyboards with a basic
 set of functionality. You can override anything you want in
 a custom subclass.
 
 To set a custom height for the keyboard extension, call the
 `setHeight(to:)` function. It can be used when creating the
 keyboard, as well as when e.g. the orientation changes.
 
 To add a default longpress gesture to a cell, just call the
 `addLongPressGesture(to:with:)`. It makes the cell call the
 `handleLongPress(on:)` function when it is long pressed.
 
 
 */

import UIKit

open class KeyboardInputViewController: UIInputViewController, KeyboardPresenter {
    
    
    // MARK: - Properties
    
    open var id: String?
    
    open var keyboard = Keyboard.empty
    
    fileprivate var heightConstraint: NSLayoutConstraint?
    
    
    // MARK: - Public Functions
    
    open func addLongPressGesture(to cell: UIView, with operation: KeyboardAction) {
        let gestures = cell.gestureRecognizers ?? []
        let longPresses = gestures.filter { $0 is UILongPressGestureRecognizer }
        longPresses.forEach { cell.removeGestureRecognizer($0) }
        cell.addLongPressGestureRecognizer { [weak self] in
            self?.handleLongPress(on: operation)
        }
    }
    
    open func handleLongPress(on action: KeyboardAction) {}
    
    open func handleTap(on action: KeyboardAction) {
        switch action {
        case .backspace: textDocumentProxy.deleteBackward()
        case .character(let char): textDocumentProxy.insertText(char)
        case .nextKeyboard: advanceToNextInputMode()
        case .newLine: textDocumentProxy.insertText("\n")
        case .space: textDocumentProxy.insertText(" ")
        default: break
        }
    }
    
    open func setHeight(to height: CGFloat) {
        heightConstraint?.constant = height
        guard heightConstraint == nil else { return }
        let constraint = NSLayoutConstraint.attribute(.height, in: view, constant: height)
        constraint.priority = .required
        constraint.isActive = true
        view.addConstraint(constraint)
        heightConstraint = constraint
    }
}

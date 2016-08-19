//
//  Keyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2015-12-27.
//  Copyright © 2015 Daniel Saidi. All rights reserved.
//

import UIKit


public enum KeyboardOperation {
    case None, Backspace, Character, Emoji, NewLine, NextKeyboard, Space
}


public protocol KeyboardDelegate: class {
    func keyboard(keyboard: Keyboard, buttonLongPressed button: KeyboardButton)
    func keyboard(keyboard: Keyboard, buttonTapped button: KeyboardButton)
    func keyboardPageNumberDidChange(keyboard: Keyboard)
}


public protocol Keyboard: class {
    
    weak var delegate: KeyboardDelegate? { get set }
    
    var pageNumber: Int { get set }
    
    func setupKeyboardInViewController(vc: UIInputViewController)
}

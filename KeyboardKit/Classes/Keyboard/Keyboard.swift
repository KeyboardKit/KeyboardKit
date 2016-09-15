//
//  Keyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2015-12-27.
//  Copyright © 2015 Daniel Saidi. All rights reserved.
//

import UIKit


public enum KeyboardOperation {
    case none, backspace, character, emoji, newLine, nextKeyboard, space
}


public protocol KeyboardDelegate: class {
    func keyboard(_ keyboard: Keyboard, buttonLongPressed button: KeyboardButton)
    func keyboard(_ keyboard: Keyboard, buttonTapped button: KeyboardButton)
    func keyboardPageNumberDidChange(_ keyboard: Keyboard)
}


public protocol Keyboard: class {
    
    weak var delegate: KeyboardDelegate? { get set }
    
    var pageNumber: Int { get set }
    
    func setupKeyboardInViewController(_ vc: UIInputViewController)
}

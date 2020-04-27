//
//  KeyboardInputViewController+Gestures.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-04-27.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import UIKit


// MARK: - Internal Functions

extension KeyboardInputViewController {
    
    func addLongPressGesture(to button: KeyboardButton) {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        button.addGestureRecognizer(gesture)
    }
    
    func addRepeatingGesture(to button: KeyboardButton) {
        let gesture = RepeatingGestureRecognizer { [weak self] in
            self?.handle(.repeatPress, on: button)
        }
        button.addGestureRecognizer(gesture)
    }
    
    func addSwitchKeyboardGesture(to button: KeyboardButton) {
        guard let button = button as? UIButton else { return }
        button.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
    }
    
    func addTapGesture(to button: KeyboardButton) {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        button.addGestureRecognizer(gesture)
    }
    
    func handle(_ gesture: KeyboardGesture, on button: UIView?) {
        guard let button = button as? KeyboardButton else { return }
        keyboardActionHandler.handle(gesture, on: button.action, sender: self)
    }
}


// MARK: - Private Actions

@objc private extension KeyboardInputViewController {
    
    func handleLongPress(_ gesture: UIGestureRecognizer) {
        guard gesture.state == .began else { return }
        handle(.longPress, on: gesture.view)
    }
    
    func handleTap(_ gesture: UIGestureRecognizer) {
        handle(.tap, on: gesture.view)
    }
    
    func handleRepeat(_ gesture: UIGestureRecognizer) {
        handle(.repeatPress, on: gesture.view)
    }
}

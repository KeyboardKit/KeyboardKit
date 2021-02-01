//
//  UIKeyboardButton+Gestures.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-28.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIKeyboardButton {
    
    /**
     This function adds keyboard gestures to the button in a
     certain input view controller.
     */
    func addKeyboardGestures(in vc: KeyboardInputViewController) {
        gestureRecognizers?.forEach { removeGestureRecognizer($0) }
        if action == .nextKeyboard { return setupAsNextKeyboardButton(in: vc) }
        vc.addDoubleTapGesture(to: self)
        vc.addTapGesture(to: self)
        vc.addLongPressGesture(to: self)
        vc.addRepeatingGesture(to: self)
    }
}

private extension KeyboardInputViewController {
    
    func addDoubleTapGesture(to button: UIKeyboardButton) {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        gesture.numberOfTapsRequired = 2
        gesture.delegate = self
        button.addGestureRecognizer(gesture)
    }
    
    func addLongPressGesture(to button: UIKeyboardButton) {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        button.addGestureRecognizer(gesture)
    }
    
    func addRepeatingGesture(to button: UIKeyboardButton) {
        weak var button = button
        let gesture = UIRepeatingGestureRecognizer { [weak self] in
            self?.handle(.repeatPress, on: button)
        }
        button?.addGestureRecognizer(gesture)
    }
    
    func addTapGesture(to button: UIKeyboardButton) {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        button.addGestureRecognizer(gesture)
    }
    
    func handle(_ gesture: KeyboardGesture, on button: UIView?) {
        guard let button = button as? UIKeyboardButton else { return }
        keyboardActionHandler.handle(gesture, on: button.action, sender: button)
    }
}

@objc private extension KeyboardInputViewController {
    
    func handleDoubleTap(_ gesture: UIGestureRecognizer) {
        handle(.doubleTap, on: gesture.view)
    }
    
    func handleLongPress(_ gesture: UIGestureRecognizer) {
        guard gesture.state == .began else { return }
        handle(.longPress, on: gesture.view)
    }
    
    func handleTap(_ gesture: UIGestureRecognizer) {
        handle(.tap, on: gesture.view)
        (gesture.view as? UIKeyboardButton)?.animateStandardTap()
    }
    
    func handleRepeat(_ gesture: UIGestureRecognizer) {
        handle(.repeatPress, on: gesture.view)
    }
}


// MARK: - UIGestureRecognizerDelegate

/**
 This delegate is required, to be able to use the double-tap
 gesture without cancelling out single taps.
 */
extension KeyboardInputViewController: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}

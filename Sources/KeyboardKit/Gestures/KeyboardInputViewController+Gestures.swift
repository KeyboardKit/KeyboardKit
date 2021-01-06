//
//  KeyboardInputViewController+Gestures.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-04-27.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit


// MARK: - Internal Functions

extension KeyboardInputViewController {
    
    func addStandardKeyboardGestures(to button: KeyboardButton) {
        addDoubleTapGesture(to: button)
        addTapGesture(to: button)
        addLongPressGesture(to: button)
        addRepeatingGesture(to: button)
    }
    
    func addNextKeyboardGesture(to button: KeyboardButton) {
        guard let button = button as? UIButton else { return }
        setupNextKeyboardButton(button)
    }
}


// MARK: - Private Functions

private extension KeyboardInputViewController {
    
    func addDoubleTapGesture(to button: KeyboardButton) {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        gesture.numberOfTapsRequired = 2
        gesture.delegate = self
        button.addGestureRecognizer(gesture)
    }
    
    func addLongPressGesture(to button: KeyboardButton) {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        button.addGestureRecognizer(gesture)
    }
    
    func addRepeatingGesture(to button: KeyboardButton) {
        weak var button = button
        let gesture = RepeatingGestureRecognizer { [weak self] in
            self?.handle(.repeatPress, on: button)
        }
        button?.addGestureRecognizer(gesture)
    }
    
    func addTapGesture(to button: KeyboardButton) {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        button.addGestureRecognizer(gesture)
    }
    
    func handle(_ gesture: KeyboardGesture, on button: UIView?) {
        guard let button = button as? KeyboardButton else { return }
        context.actionHandler.handle(gesture, on: button.action, sender: button)
    }
}


// MARK: - Private Actions

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

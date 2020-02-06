//
//  UIView+RepeatingAction.swift
//  iExtra
//
//  Created by Daniel Saidi on 2019-05-30.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIView {
    
    typealias RepeatingAction = (() -> Void)
    
    /**
     Add a repeating gesture recognizer to the view.
    */
    func addRepeatingAction(
        initialDelay: TimeInterval = 0.8,
        repeatInterval: TimeInterval = 0.1,
        action: @escaping RepeatingAction) {
        isUserInteractionEnabled = true
        let recognizer = RepeatingGestureRecognizer(
            initialDelay: initialDelay,
            repeatInterval: repeatInterval,
            action: action)
        addGestureRecognizer(recognizer)
    }
    
    /**
     Remove all repeating gestures recognizer from the view.
    */
    func removeRepeatingAction() {
        gestureRecognizers?
            .filter { $0 is RepeatingGestureRecognizer }
            .forEach { removeGestureRecognizer($0) }
    }
}

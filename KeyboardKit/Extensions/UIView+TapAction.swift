//
//  UIView+ActionTapGesture.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2017-12-12.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//
//  Reference: https://medium.com/@sdrzn/adding-gesture-recognizers-with-closures-instead-of-selectors-9fb3e09a8f0b
//

/*
 
 This extension applies tap gesture recognizers using action
 blocks instead of the target/selector pattern.
 
 */

import UIKit

public extension UIView {
    
    typealias TapAction = (() -> Void)
    
    func addTapAction(numberOfTapsRequired: Int = 1, action: TapAction?) {
        tapAction = action
        isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        recognizer.numberOfTapsRequired = numberOfTapsRequired
        addGestureRecognizer(recognizer)
    }
    
    func removeTapAction() {
        guard let gestures = gestureRecognizers else { return }
        let taps = gestures.filter { $0 is UITapGestureRecognizer }
        taps.forEach { removeGestureRecognizer($0) }
    }
}

private extension UIView {
    
    struct Key { static var id = "tapAction" }
    
    var tapAction: TapAction? {
        get {
            return objc_getAssociatedObject(self, &Key.id) as? TapAction
        }
        set {
            guard let value = newValue else { return }
            let policy = objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN
            objc_setAssociatedObject(self, &Key.id, value, policy)
        }
    }

    @objc func handleTap(sender: UITapGestureRecognizer) {
        tapAction?()
    }
}

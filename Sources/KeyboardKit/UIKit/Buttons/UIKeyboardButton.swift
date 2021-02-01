//
//  UIKeyboardButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-26.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This protocol can be implemented by views that can be added
 to button rows and collection views.
 
 For convenience, you can use `UIKeyboardButtonView` instead
 of implementing this protocol from scratch.
 */
public protocol UIKeyboardButton: UIKeyboardButtonRowComponent {
    
    var action: KeyboardAction { get }
    var secondaryAction: KeyboardAction? { get }
}


// MARK: - Animations

public extension UIKeyboardButton {
    
    func animateStandardPress(factor: CGFloat = 1.1, completion: (() -> Void)? = nil) {
        let transform = CGAffineTransform(scaleX: factor, y: factor)
        animateTransform(transform, completion: completion)
    }
    
    func animateStandardRelease(completion: (() -> Void)? = nil) {
        animateTransform(.identity, completion: completion)
    }
    
    func animateStandardTap(completion: (() -> Void)? = nil) {
        animateStandardPress { [weak self] in
            self?.animateStandardRelease(completion: completion)
        }
    }
}

private extension UIKeyboardButton {
    
    func animateTransform(_ transform: CGAffineTransform, completion: (() -> Void)? = nil) {
        UIView.animate(
            withDuration: 0.05,
            delay: 0,
            options: [.curveLinear, .allowUserInteraction],
            animations: { [weak self] in self?.transform = transform },
            completion: { _ in completion?() }
        )
    }
}

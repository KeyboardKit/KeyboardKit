//
//  KeyboardButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-26.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This protocol can be implemented by views that can be added
 to button rows and collection views.
 
 For convenience, you can use the `KeyboardButtonView` class
 instead of implementing this protocol from scratch.
 */
public protocol KeyboardButton: KeyboardButtonRowComponent {
    
    var action: KeyboardAction { get }
    var secondaryAction: KeyboardAction? { get }
}


// MARK: - Animations

public extension KeyboardButton {
    
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

private extension KeyboardButton {
    
    func animateTransform(_ transform: CGAffineTransform, completion: (() -> Void)? = nil) {
        UIView.animate(
            withDuration: 0.1,
            delay: 0,
            options: [.curveEaseOut, .allowUserInteraction],
            animations: { [weak self] in self?.transform = transform },
            completion: { _ in completion?() }
        )
    }
}

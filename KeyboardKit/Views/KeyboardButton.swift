//
//  KeyboardButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-26.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This protocol should be implemented by any view that can be
 used as keyboard buttons, since it makes it possible to add
 it to keyboard button rows and collection views.
 
 For convenience, you can use the `KeyboardButtonView` class
 instead of implementing this protocol from scratch.
 
 */

import UIKit

public protocol KeyboardButton: KeyboardButtonRowComponent {
    
    var action: KeyboardAction { get }
    var secondaryAction: KeyboardAction? { get }
}



// MARK: - Animations

public extension KeyboardButton {
    
    func animateStandardPress(factor: CGFloat = 0.8, completion: (() -> ())? = nil) {
        let transform = CGAffineTransform(scaleX: factor, y: factor)
        animateTransform(transform, completion: completion)
    }
    
    func animateStandardRelease(completion: (() -> ())? = nil) {
        animateTransform(.identity, completion: completion)
    }
    
    func animateStandardTap(completion: (() -> ())? = nil) {
        animateStandardPress { [weak self] in
            self?.animateStandardRelease(completion: completion)
        }
    }
}

private extension KeyboardButton {
    
    func animateTransform(_ transform: CGAffineTransform, completion: (() -> ())? = nil) {
        UIView.animate(
            withDuration: 0.123,
            delay: 0,
            options: [.curveEaseOut],
            animations: { [weak self] in self?.transform = transform },
            completion: { _ in completion?() }
        )
    }
}

//
//  KeyboardButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-26.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

public protocol KeyboardButton: KeyboardButtonRowComponent {
    
    var action: KeyboardAction { get }
}

public extension KeyboardButton {
    
    func animateDefaultPress(factor: CGFloat = 0.8, completion: (() -> ())? = nil) {
        let transform = CGAffineTransform(scaleX: factor, y: factor)
        animateTransform(transform, completion: completion)
    }
    
    func animateDefaultRelease(completion: (() -> ())? = nil) {
        animateTransform(.identity, completion: completion)
    }
    
    func animateDefaultTap(completion: (() -> ())? = nil) {
        animateDefaultPress { [weak self] in
            self?.animateDefaultRelease(completion: completion)
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

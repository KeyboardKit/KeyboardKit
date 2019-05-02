//
//  KeyboardButtonView.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This button implements `KeyboardButton` and also provides a
 setup function that sets the button up properly.
 
 */

import UIKit

open class KeyboardButtonView: UIButton, KeyboardButton {
    
    public private(set) var action: KeyboardAction = .none
    
    public private(set) lazy var widthConstraint: NSLayoutConstraint = {
        let constraint = widthAnchor.constraint(equalToConstant: 50)
        constraint.isActive = true
        return constraint
    }()
    
    public func setup(with action: KeyboardAction, in viewController: KeyboardInputViewController) {
        self.action = action
        viewController.addKeyboardGestures(to: self)
    }
}

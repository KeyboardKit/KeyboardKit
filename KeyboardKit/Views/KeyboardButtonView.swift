//
//  KeyboardButtonView.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

open class KeyboardButtonView: UIButton, KeyboardButton, KeyboardButtonRowComponent {
    
    deinit {
        print("giuheaihgeu")
    }
    public private(set) var action: KeyboardAction = .none
    
    public lazy var widthConstraint: NSLayoutConstraint = {
        let constraint = widthAnchor.constraint(equalToConstant: 50)
        constraint.isActive = true
        return constraint
    }()
    
    public func setup(with action: KeyboardAction, in viewController: KeyboardInputViewController) {
        self.action = action
        viewController.addKeyboardGestures(to: self)
    }
}

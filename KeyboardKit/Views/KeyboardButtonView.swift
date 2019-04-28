//
//  KeyboardButtonView.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

public class KeyboardButtonView: UIView, KeyboardButton, KeyboardButtonRowComponent {
    
    public lazy var widthConstraint: NSLayoutConstraint = {
        let constraint = widthAnchor.constraint(equalToConstant: 50)
        constraint.isActive = true
        return constraint
    }()
}

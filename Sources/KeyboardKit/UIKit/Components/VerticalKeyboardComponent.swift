//
//  VerticalKeyboardComponent.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-20.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This protocol represents a view component that can be added
 to a vertically flowing part of the keyboard.
 */
public protocol VerticalKeyboardComponent: UIView {
    
    var heightConstraint: NSLayoutConstraint? { get set }
}

public extension VerticalKeyboardComponent {
    
    var height: CGFloat {
        get { heightConstraint?.constant ?? intrinsicContentSize.height }
        set { setHeight(to: newValue) }
    }
}

private extension VerticalKeyboardComponent {
    
    func setHeight(to height: CGFloat) {
        heightConstraint = heightConstraint ?? heightAnchor.constraint(equalToConstant: height)
        heightConstraint?.priority = .defaultHigh
        heightConstraint?.constant = height
        heightConstraint?.isActive = true
    }
}

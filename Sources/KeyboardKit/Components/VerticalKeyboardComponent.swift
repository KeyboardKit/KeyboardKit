//
//  VerticalKeyboardComponent.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-20.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This protocol describes any kind of views that can be added
 to any vertically flowing part of the keyboard.
 
 */

import UIKit

public protocol VerticalKeyboardComponent: UIView {
    
    var heightConstraint: NSLayoutConstraint? { get set }
}

public extension VerticalKeyboardComponent {
    
    var height: CGFloat {
        get { return heightConstraint?.constant ?? intrinsicContentSize.height }
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

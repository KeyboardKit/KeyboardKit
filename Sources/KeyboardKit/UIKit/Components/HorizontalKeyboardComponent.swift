//
//  HorizontalKeyboardComponent.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-20.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This protocol represents a view component that can be added
 to a horizontally flowing part of the keyboard.
 
 If a stack view uses another distribution than `fillEqually`,
 you must specify a `width` for each row component.
 */
public protocol HorizontalKeyboardComponent: UIView {
    
    var widthConstraint: NSLayoutConstraint? { get set }
}

public extension HorizontalKeyboardComponent {
    
    /**
     This property gets/sets the constant of the component's
     height constraint.
     */
    var width: CGFloat {
        get { widthConstraint?.constant ?? intrinsicContentSize.width }
        set { setWidth(to: newValue) }
    }
}

private extension HorizontalKeyboardComponent {
    
    func setWidth(to width: CGFloat) {
        widthConstraint = widthConstraint ?? widthAnchor.constraint(equalToConstant: width)
        widthConstraint?.priority = .defaultLow
        widthConstraint?.constant = width
        widthConstraint?.isActive = true
    }
}

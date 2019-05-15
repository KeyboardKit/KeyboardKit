//
//  KeyboardButtonRowComponent.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 A keyboard button row component is a view that can be added
 to a keyboard button row's horizontal stack view. For stack
 a different distribution than `.fillEqually`, you must give
 each row component a specific width.
 
 */

import UIKit

public protocol KeyboardButtonRowComponent: UIView {
    
    var widthConstraint: NSLayoutConstraint? { get set }
}

public extension KeyboardButtonRowComponent {
    
    var width: CGFloat {
        get { return widthConstraint?.constant ?? intrinsicContentSize.width }
        set { setWidth(to: newValue) }
    }
}

private extension KeyboardButtonRowComponent {
    
    func setWidth(to width: CGFloat) {
        widthConstraint = widthConstraint ?? widthAnchor.constraint(equalToConstant: width)
        widthConstraint?.priority = .defaultLow
        widthConstraint?.constant = width
        widthConstraint?.isActive = true
    }
}

//
//  KeyboardComponent.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 Keyboard stack view components are "rows" in the main input
 view controller keyboard stack view, e.g. a toolbar, button
 row, collection view, auto-complete component etc.
 
 */

import UIKit

public protocol KeyboardStackViewComponent: UIView {

    var heightConstraint: NSLayoutConstraint? { get set }
}

public extension KeyboardStackViewComponent {
    
    var height: CGFloat {
        get { return heightConstraint?.constant ?? intrinsicContentSize.height }
        set { setHeight(to: newValue) }
    }
}

private extension KeyboardStackViewComponent {
    
    func setHeight(to height: CGFloat) {
        heightConstraint = heightConstraint ?? heightAnchor.constraint(equalToConstant: height)
        heightConstraint?.priority = .defaultHigh
        heightConstraint?.constant = height
        heightConstraint?.isActive = true
    }
}

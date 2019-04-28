//
//  KeyboardComponent.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 A keyboard stack view component is a row in a main keyboard
 stack view. It can be system button rows, the keyboard view
 itself, auto-complete components etc.
 
 */

import UIKit

public protocol KeyboardStackViewComponent: UIView {

    var heightConstraint: NSLayoutConstraint { get }
}

public extension KeyboardStackViewComponent {
    
    var height: CGFloat {
        get { return heightConstraint.constant }
        set { heightConstraint.constant = newValue }
    }
}

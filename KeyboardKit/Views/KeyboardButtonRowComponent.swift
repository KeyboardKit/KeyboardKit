//
//  KeyboardButtonRowComponent.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 A keyboard button row component is a view that can be added
 to a keyboard button row's horizontal stack view.
 
 The keyboard button row's stack view uses `.fillEqually` by
 default. If you want to switch to `.fillProportionally` you
 have to change the `widthConstraint` of each component in a
 way that makes the proportional distribution work correctly.
 
 For instance, if you want a three button row where the left
 and right button takes up 10% of the width while the center
 button takes up the remaining 80%, set the `width` property
 to `10` for the left and right buttons then to `80` for the
 center button.
 
 */

import UIKit

public protocol KeyboardButtonRowComponent: UIView {
    
    var widthConstraint: NSLayoutConstraint { get }
}

public extension KeyboardButtonRowComponent {
    
    var width: CGFloat {
        get { return widthConstraint.constant }
        set { widthConstraint.constant = newValue }
    }
}

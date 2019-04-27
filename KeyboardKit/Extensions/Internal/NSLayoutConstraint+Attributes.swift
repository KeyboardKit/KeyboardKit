//
//  NSLayoutConstraint+Attributes.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-03-12.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This internal extension is used by KeyboardKit when it sets
 the height of the keyboard extension.
 
 */

import Foundation

extension NSLayoutConstraint {
    
    static func attribute(_ attribute: NSLayoutConstraint.Attribute, in view: UIView, constant: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: view, attribute: attribute, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: constant)
        constraint.priority = .required
        return constraint
    }
}

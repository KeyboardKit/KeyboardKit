//
//  UIView+Nib.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2016-11-09.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This extension returns the standard nib or nib name for any
 view, e.g. a collection view cell.
 
 */

import UIKit

public extension UIView {
    
    static var defaultNibName: String {
        return String(describing: self)
    }
    
    static func fromNib(
        owner: Any,
        named nibName: String = defaultNibName,
        in bundle: Bundle = Bundle.main) -> Self {
        return fromNibTyped(owner: owner)
    }
    
    static func fromNibTyped<T: UIView>(
        owner: Any,
        named nibName: String = T.defaultNibName,
        in bundle: Bundle = Bundle.main) -> T {
        let nibs = bundle.loadNibNamed(nibName, owner: owner, options: nil)
        guard let nib = nibs?[0] as? T else { fatalError("initWithDefaultNib failed") }
        return nib
    }
}

//
//  UIView+Nib.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2016-11-09.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This extension returns the standard nib or nib name for any
 view, e.g. a collection view cell. I use it to register and
 dequeue collection view cells in the demo application.
 
 */

import UIKit

public extension UIView {
    
    
    // MARK: - Static Properties
    
    public static var defaultNib: UINib {
        return UINib(nibName: defaultNibName, bundle: nil)
    }
    
    public static var defaultNibName: String {
        return className
    }
    
    
    // MARK: - Static Functions
    
    public static func initWithDefaultNib(owner: Any) -> Self {
        return initWithDefaultNibTyped(owner: owner)
    }
    
    public static func initWithDefaultNibTyped<T>(owner: Any) -> T {
        let bundle = Bundle.main
        let nibName = defaultNibName
        let nibs = bundle.loadNibNamed(nibName, owner: owner, options: nil)
        guard let nib = nibs?[0] as? T else { fatalError("initWithDefaultNib failed") }
        return nib
    }
}

//
//  UIView+Nib.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2016-11-09.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This extension can create view instances from nibs. It uses
 the view's class name and bundle by default.
 
 */

import UIKit

public extension UIView {
    
    /**
     
     The view's default nib in the main bundle.
 
     */
    static var defaultNib: UINib {
        return defaultNib()
    }
    
    /**
     
     The view's default nib name.
     
     */
    static var defaultNibName: String {
        return String(describing: self)
    }
    
    /**
     
     Get the view's default nib in a certain bundle.
     
     */
    static func defaultNib(in bundle: Bundle = .main) -> UINib {
        return UINib(nibName: defaultNibName, bundle: bundle)
    }
    
    /**
     
     Create an instance of the view by resolving a nib from
     any bundle. By default, it uses the default nib name in
     the main bundle.
     
     */
    static func fromNib(
        owner: Any,
        named nibName: String = defaultNibName,
        in bundle: Bundle = .main) -> Self {
        return fromNibTyped(owner: owner)
    }
    
    
    /**
     
     Create a typed instance of the view by resolving a nib
     from any bundle.
     
     This is mostly meant to be used by the untyped `fromNib`
     function.
     
     */
    static func fromNibTyped<T: UIView>(
        owner: Any,
        named nibName: String = T.defaultNibName,
        in bundle: Bundle = .main) -> T {
        let nibs = bundle.loadNibNamed(nibName, owner: owner, options: nil)
        guard let nib = nibs?[0] as? T else { fatalError("initWithDefaultNib failed") }
        return nib
    }
}

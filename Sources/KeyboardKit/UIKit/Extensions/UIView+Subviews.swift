//
//  UIView+Subviews.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIView {
    
    /**
     Add a subview with an option to adjust its anchords to
     make it fill its superview.
     */
    func addSubview(_ subview: UIView, fill: Bool) {
        addSubview(subview)
        guard fill else { return }
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.topAnchor.constraint(equalTo: topAnchor).isActive = true
        subview.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        subview.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    /**
     Add a trailing subview with a certain width.
     */
    func addTrailingSubview(_ subview: UIView, width: CGFloat, height: CGFloat? = nil) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        subview.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        subview.widthAnchor.constraint(equalToConstant: width).isActive = true
        if let height = height {
            subview.heightAnchor.constraint(equalToConstant: height).isActive = true
        } else {
            subview.topAnchor.constraint(equalTo: topAnchor).isActive = true
            subview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }
    }
}

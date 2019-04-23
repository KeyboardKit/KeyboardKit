//
//  UIView+Subviews.swift
//  iExtra
//
//  Created by Daniel Saidi on 2017-02-08.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

import UIKit

extension UIView {
    
    var hasSubviews: Bool {
        return subviews.count > 0
    }
    
    func addSubview(_ subview: UIView, fill: Bool) {
        guard fill else { return addSubview(subview) }
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.topAnchor.constraint(equalTo: topAnchor).isActive = true
        subview.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        subview.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func addSubviewBottommost(_ view: UIView) {
        guard let first = subviews.first else { return addSubview(view) }
        insertSubview(view, belowSubview: first)
    }
    
    func addSubviewTopmost(_ view: UIView) {
        guard let last = subviews.last else { return addSubview(view) }
        insertSubview(view, aboveSubview: last)
    }
    
    func removeSubviews(_ subviews: [UIView]) {
        subviews.forEach { $0.removeFromSuperview() }
    }
}

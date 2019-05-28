//
//  UIStackView+Subviews.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-02.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This extension simplifies working with arranged subviews in
 stack view.
 
 */

import UIKit

public extension UIStackView {
    
    func addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach {
            addArrangedSubview($0)
        }
    }
    
    func removeArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach {
            removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
    
    func removeAllArrangedSubviews() {
        removeArrangedSubviews(arrangedSubviews)
    }
}

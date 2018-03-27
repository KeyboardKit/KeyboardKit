//
//  UIView+Shadow.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2016-10-12.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIView {

    public func addBadgeShadow() {
        let offset = CGSize(width: 1, height: 1)
        addDropShadow(withOffset: offset, radius: 1, opacity: 0.5)
    }
    
    public func addDropShadow(withOffset offset: CGSize, radius: Double, opacity: Double, color: UIColor = .black) {
        layer.shadowOffset = offset
        layer.shadowRadius = CGFloat(radius)
        layer.shadowOpacity = Float(opacity)
        layer.shadowColor = color.cgColor
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    public func removeDropShadow() {
        layer.shadowOpacity = 0
    }
}

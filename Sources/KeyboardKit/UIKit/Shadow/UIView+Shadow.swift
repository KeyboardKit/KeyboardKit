//
//  UIView+ShadowStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-19.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIView {
    
    /**
     Apply a certain drop shadow effect.
     */
    func applyShadow(_ shadow: UIShadow) {
        layer.applyShadow(
            color: shadow.color,
            alpha: shadow.alpha,
            x: shadow.x,
            y: shadow.y,
            blur: shadow.blur,
            spread: shadow.spread)
    }
}

private extension CALayer {
    
    func applyShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0) {
        let scale = UIScreen.main.scale
        masksToBounds = false
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = .zero
        shadowRadius = blur / 2.0
        let rect = bounds.insetBy(dx: -spread, dy: -spread)
        let inset = UIEdgeInsets(top: y, left: 0, bottom: 0, right: 0)
        let path = UIBezierPath(roundedRect: rect.offsetBy(dx: x, dy: y), cornerRadius: cornerRadius + spread)
        path.append(UIBezierPath(roundedRect: bounds.inset(by: inset), cornerRadius: cornerRadius).reversing())
        shadowPath = path.cgPath
        shouldRasterize = true
        rasterizationScale = scale
        contentsScale = scale
    }
}

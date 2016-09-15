//
//  UIImage_BackgroundColor.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2016-01-29.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIImage {
    
    public func image(withBackgroundColor color: UIColor) -> UIImage {
        return image(withBackgroundColor: color, cornerRadius: 0)
    }
    
    public func image(withBackgroundColor color: UIColor, cornerRadius: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        let context = UIGraphicsGetCurrentContext()
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath
        context?.addPath(path)
        context?.setFillColor(color.cgColor)
        context?.closePath()
        context?.fillPath()
        
        draw(in: rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}

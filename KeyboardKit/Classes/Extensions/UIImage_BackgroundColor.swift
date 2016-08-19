//
//  UIImage_BackgroundColor.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2016-01-29.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIImage {
    
    public func imageWithBackgroundColor(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        let context = UIGraphicsGetCurrentContext()
        let rect = CGRectMake(0, 0, size.width, size.height)
        
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 20).CGPath
        CGContextAddPath(context, path)
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextClosePath(context)
        CGContextFillPath(context)

        drawInRect(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

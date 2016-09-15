//
//  UIImage_Resize.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2016-01-21.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIImage {
    
    public func image(resizedToWidth points: CGFloat) -> UIImage {
        let width = points * scale
        let ratio = width / size.width
        let height = size.height * ratio
        let newSize = CGSize(width: width, height: height)
        return image(resizedToSize: newSize, quality: .high)
    }
    
    public func image(resizedToHeight points: CGFloat) -> UIImage {
        let height = points * scale
        let ratio = height / size.height
        let width = size.width * ratio
        let newSize = CGSize(width: width, height: height)
        return image(resizedToSize: newSize, quality: .high)
    }
    
    public func image(resizedToSize newSize: CGSize, quality: CGInterpolationQuality) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result ?? UIImage()
    }
}

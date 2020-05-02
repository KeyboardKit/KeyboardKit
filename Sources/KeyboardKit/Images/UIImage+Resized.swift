//
//  UIImage+Resized.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-01.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIImage {
    
    /**
     Create a resized copy of the image, using a custom size.
     */
    func resized(to newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    
    /**
     Create a resized copy of the image, using a new height.
     
     This operation will preserve the original aspect ratio.
     */
    func resized(toHeight points: CGFloat) -> UIImage? {
        guard canResize(to: points) else { return nil }
        let height = points * scale
        let ratio = height / size.height
        let width = size.width * ratio
        let newSize = CGSize(width: width, height: height)
        return resized(to: newSize)
    }
    
    /**
     Create a resized copy of the image, using a new width.
     
     This operation will preserve the original aspect ratio.
     */
    func resized(toWidth points: CGFloat) -> UIImage? {
        guard canResize(to: points) else { return nil }
        let width = points * scale
        let ratio = width / size.width
        let height = size.height * ratio
        let newSize = CGSize(width: width, height: height)
        return resized(to: newSize)
    }
}

private extension UIImage {
    
    var hasValidSize: Bool {
        size.width > 0 && size.height > 0
    }
    
    func canResize(to points: CGFloat) -> Bool {
        hasValidSize && points > 0
    }
}

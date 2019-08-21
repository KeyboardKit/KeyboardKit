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
     
     Returns a resized copy of the image, using a new size
     that can affect the original aspect ratio.
     
     */
    func resized(to newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    
    /**
     
     Returns a resized copy of the image, using a new height
     while preserving the original aspect ratio.
     
     */
    func resized(toHeight points: CGFloat) -> UIImage? {
        let height = points * scale
        let ratio = height / size.height
        let width = size.width * ratio
        let newSize = CGSize(width: width, height: height)
        return resized(to: newSize)
    }
    
    /**
     
     Returns a resized copy of the image, using a new width
     while preserving the original aspect ratio.
     
     */
    func resized(toWidth points: CGFloat) -> UIImage? {
        let width = points * scale
        let ratio = width / size.width
        let height = size.height * ratio
        let newSize = CGSize(width: width, height: height)
        return resized(to: newSize)
    }
}

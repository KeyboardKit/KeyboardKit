//
//  UIImage+Async.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-01.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This extension draws images into a minimal rect then return
 the image. This caches image, which will cause it to render
 quicker later on.
 
 */

import UIKit

public extension UIImage {
    
    public typealias AsyncImageBlock = (_ image: UIImage?) -> ()
    
    public class func async(named name: String, callback: @escaping AsyncImageBlock) { {
        self.loadAsync(named: name) } ~> { callback($0) }
    }
}

fileprivate extension UIImage {
    
    class func loadAsync(named name: String) -> UIImage? {
        let image = UIImage(named: name)
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        let context = UIGraphicsGetCurrentContext()
        guard let cgImage = image?.cgImage else { return nil }
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        context?.draw(cgImage, in: rect)
        UIGraphicsEndImageContext()
        return image
    }
}

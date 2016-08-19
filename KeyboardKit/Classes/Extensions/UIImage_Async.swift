//
//  UIImage_Async.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2016-01-22.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIImage {
    
    public class func imageNamedAsync(name: String, callback: ((image: UIImage)->())) {
        {   
            let image = UIImage(named: name)
            UIGraphicsBeginImageContext(CGSizeMake(1,1));
            let context = UIGraphicsGetCurrentContext();
            CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), image?.CGImage);
            UIGraphicsEndImageContext();
            return image!
        } ~> {
            callback(image: $0)
        }
    }
}

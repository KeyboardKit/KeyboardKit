//
//  UIImage_Async.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2016-01-22.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIImage {
    
    public class func async(named name: String, callback: @escaping ((_ image: UIImage)->())) {
        {   
            let image = UIImage(named: name)
            UIGraphicsBeginImageContext(CGSize(width: 1,height: 1));
            let context = UIGraphicsGetCurrentContext();
            context?.draw((image?.cgImage)!, in: CGRect(x: 0, y: 0, width: 1, height: 1));
            UIGraphicsEndImageContext();
            return image!
        } ~> {
            callback($0)
        }
    }
}

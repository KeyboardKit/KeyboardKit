//
//  UIColor_Copy.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2016-08-18.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIImage {
    
    public func copyToPasteboard() {
        let pasteBoard = UIPasteboard.generalPasteboard()
        let image = imageWithBackgroundColor(UIColor.whiteColor())
        let data = UIImagePNGRepresentation(image)!
        pasteBoard.setData(data, forPasteboardType:"public.png");
    }
}

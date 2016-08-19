//
//  UIColor_Copy.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2016-08-18.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIImage {
    
    public func copyToPasteboardWithWidth(points: CGFloat) {
        let pasteBoard = UIPasteboard.generalPasteboard()
        let image = imageByResizingToWidth(points)
        let bgImage = image.imageWithBackgroundColor(UIColor.whiteColor())
        let data = UIImagePNGRepresentation(bgImage)!
        pasteBoard.setData(data, forPasteboardType:"public.png");
    }
}

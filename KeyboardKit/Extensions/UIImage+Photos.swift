//
//  UIImage+Save.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-01.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This extension saves images to the photo album. If you have
 transparent images, consider applying background colors and
 (maybe) a corner radius to them before you save them.
 
 */

import UIKit

public extension UIImage {
    
    public func saveToPhotos(completionTarget: AnyObject?, completionSelector: Selector?) {
        UIImageWriteToSavedPhotosAlbum(self, completionTarget, completionSelector, nil)
    }
}

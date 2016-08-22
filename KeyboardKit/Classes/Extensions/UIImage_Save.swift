//
//  UIImage_Save.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2016-08-18.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIImage {
    
    public func saveToPhotos(completionTarget: AnyObject?, completionSelector: Selector) {
        UIImageWriteToSavedPhotosAlbum(self, completionTarget, completionSelector, nil)
    }
}

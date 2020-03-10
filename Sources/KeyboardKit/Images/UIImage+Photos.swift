//
//  UIImage+Save.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-01.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIImage {
    
    /**
     Saves an image to the user's photo album. This requires
     the correct permission to be added to the `Info.plist`.
     */
    func saveToPhotos(completionTarget: AnyObject?, completionSelector: Selector?) {
        UIImageWriteToSavedPhotosAlbum(self, completionTarget, completionSelector, nil)
    }
    
    /**
     Saves an image to the user's photo album. This requires
     the correct permission to be added to the `Info.plist`.
     
     This function uses `StandardPhotosImageService.default`
     to save the image to photos.
     */
    func saveToPhotos(completion: @escaping (Error?) -> Void) {
        let service = StandardPhotosImageService.default
        service.saveImageToPhotos(self, completion: completion)
    }
}

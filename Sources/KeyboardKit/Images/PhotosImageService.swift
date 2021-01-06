//
//  PhotosImageService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation
import UIKit

/**
 This protocol can be implemented by classes that can save a
 `UIImage` to photos.
 
 This is useful for cases where the `UIImage` extension that
 uses a target and a selector can't be used, e.g. in SwiftUI
 where views are structs and not classes.
 */
public protocol PhotosImageService: AnyObject {
    
    func saveImageToPhotos(_ image: UIImage, completion: @escaping (Error?) -> Void)
}

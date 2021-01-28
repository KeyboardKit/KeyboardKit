//
//  UIImage+Save.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIImage {
    
    /**
     Saves an image to the user's photo album. This requires
     the correct permission to be added to the `Info.plist`.
     */
    func saveToPhotos(completion: @escaping (Error?) -> Void) {
        ImageService.default.saveImageToPhotos(self, completion: completion)
    }
}

/**
 This class is used as a target/selector holder by the image
 extension above.
 */
private class ImageService: NSObject {
    
    public typealias Completion = (Error?) -> Void

    public static private(set) var `default` = ImageService()
    
    private var completions = [Completion]()
    
    public func saveImageToPhotos(_ image: UIImage, completion: @escaping (Error?) -> Void) {
        completions.append(completion)
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveImageToPhotosDidComplete), nil)
    }
    
    @objc func saveImageToPhotosDidComplete(_ image: UIImage, error: NSError?, contextInfo: UnsafeRawPointer) {
        guard completions.count > 0 else { return }
        completions.removeFirst()(error)
    }
}

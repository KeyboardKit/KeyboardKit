//
//  StandardPhotosImageService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-10.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation
import UIKit

/**
 This class can be used to save images to photos.
 
 This is useful for cases where the `UIImage` extension that
 uses a target and a selector can't be used, e.g. in SwiftUI
 where views are structs and not classes. 
 */
public class StandardPhotosImageService: NSObject, PhotosImageService {
    
    public typealias Completion = (Error?) -> Void

    public static private(set) var `default` = StandardPhotosImageService()
    
    private var completions = [Completion]()
    
    public func saveImageToPhotos(_ image: UIImage, completion: @escaping (Error?) -> Void) {
        completions.append(completion)
        image.saveToPhotos(completionTarget: self, completionSelector: #selector(didSave(_:error:contextInfo:)))
    }
    
    @objc func didSave(_ image: UIImage, error: NSError?, contextInfo: UnsafeRawPointer) {
        guard completions.count > 0 else { return }
        completions.removeFirst()(error)
    }
}

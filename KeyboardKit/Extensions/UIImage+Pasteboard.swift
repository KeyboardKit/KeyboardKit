//
//  UIColor+Copy.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-01.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This extension copies images to the pasteboard. If you have
 transparent images, consider applying background colors and
 (maybe) a corner radius to them before you copy them, using
 the `UIImage+Tinted` extension.
 
 */

import UIKit

public extension UIImage {
    
    func copyToPasteboard() -> Bool {
        guard let data = pngData() else { return false }
        let pasteBoard = UIPasteboard.general
        pasteBoard.setData(data, forPasteboardType: "public.png")
        return true
    }
}

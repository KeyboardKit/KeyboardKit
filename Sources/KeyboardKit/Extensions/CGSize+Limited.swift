//
//  CGSize+Limited.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-01-29.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import CoreGraphics

extension CGSize {
    
    /**
     Limit a size's width and height to that of another size.
     */
    func limited(to size: CGSize) -> CGSize {
        CGSize(
            width: min(width, size.width),
            height: min(height, size.height)
        )
    }
}

//
//  CGSize+Limited.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-01-29.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
//

import CoreGraphics

extension CGSize {
    
    /// Limit a size to another size.
    func limited(to size: CGSize) -> CGSize {
        CGSize(
            width: min(width, size.width),
            height: min(height, size.height)
        )
    }
}

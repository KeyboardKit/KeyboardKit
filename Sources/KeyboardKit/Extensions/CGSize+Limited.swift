//
//  CGSize+Limited.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-01-29.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import CoreGraphics

extension CGSize {
    
    func limited(to size: CGSize) -> CGSize {
        CGSize(
            width: min(width, size.width),
            height: min(height, size.height))
    }
}

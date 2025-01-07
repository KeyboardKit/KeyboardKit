//
//  CGRect+Valid.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-23.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import CoreGraphics

extension CGRect {
    
    /// Check if the rect is valid for being drawn in a path.
    var isValidForPath: Bool { !width.isNaN && !height.isNaN }
}

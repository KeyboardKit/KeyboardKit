//
//  CGRect+Valid.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-23.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import CoreGraphics

extension CGRect {
    
    /**
     This internal property is used to abort draving invalid
     paths for views that have not yet been given a frame.
     */
    var isValidForPath: Bool { !width.isNaN && !height.isNaN }
}

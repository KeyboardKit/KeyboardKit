//
//  CGRect+Valid.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-23.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import CoreGraphics

extension CGRect {
    
    var isValidForPath: Bool { !width.isNaN && !height.isNaN }
}

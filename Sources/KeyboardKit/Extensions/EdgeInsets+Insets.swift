//
//  UIEdgeInsets+Insets.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-02.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import SwiftUI

extension EdgeInsets {
    
    /// Create horizontal and vertical insets.
    init(
        horizontal: CGFloat,
        vertical: CGFloat
    ) {
        self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }
}

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
    
    init(
        horizontal: CGFloat,
        vertical: CGFloat
    ) {
        self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }
    
    init(
        optionalTop top: CGFloat = 0,
        leading: CGFloat = 0,
        bottom: CGFloat = 0,
        trailing: CGFloat = 0
    ) {
        self.init(
            top: top,
            leading: leading,
            bottom: bottom,
            trailing: trailing
        )
    }

    static let zero = Self.init(optionalTop: 0)
}

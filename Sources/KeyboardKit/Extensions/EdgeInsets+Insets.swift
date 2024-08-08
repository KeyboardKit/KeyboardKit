//
//  UIEdgeInsets+Insets.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-02.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import SwiftUI

extension EdgeInsets {

    init(
        all value: CGFloat
    ) {
        self.init(
            horizontal: value,
            vertical: value
        )
    }

    init(
        horizontal: CGFloat,
        vertical: CGFloat
    ) {
        self.init(
            top: vertical,
            leading: horizontal,
            bottom: vertical,
            trailing: horizontal
        )
    }


    init(
        top: CGFloat,
        bottom: CGFloat = 0
    ) {
        self.init(
            top: top,
            leading: 0,
            bottom: bottom,
            trailing: 0
        )
    }

    init(
        leading: CGFloat,
        trailing: CGFloat = 0
    ) {
        self.init(
            top: 0,
            leading: leading,
            bottom: 0,
            trailing: trailing
        )
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

    static let zero = Self.init(all: 0)
}

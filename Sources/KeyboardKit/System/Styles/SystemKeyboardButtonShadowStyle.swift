//
//  SystemKeyboardButtonShadowStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-09-09.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

/**
 This style defines the shadow of a system keyboard button.
 */
public struct SystemKeyboardButtonShadowStyle {
    
    public init(
        color: Color,
        size: CGFloat) {
        self.color = color
        self.size = size
    }
    
    public let color: Color
    public let size: CGFloat
}

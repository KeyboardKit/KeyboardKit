//
//  SystemKeyboardButtonBorderStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-09-09.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

/**
 This style defines the border of a system keyboard button.
 */
public struct SystemKeyboardButtonBorderStyle {
    
    public init(
        color: Color,
        size: CGFloat) {
        self.color = color
        self.size = size
    }
    
    public let color: Color
    public let size: CGFloat
}

public extension SystemKeyboardButtonBorderStyle {
    
    /**
     This style means that no border should be applied. This
     is stye default style for system buttons.
     */
    static var noBorder: SystemKeyboardButtonBorderStyle {
        SystemKeyboardButtonBorderStyle(color: .clear, size: 0)
    }
}

//
//  KeyboardAppearance.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import SwiftUI

/**
 This protocol can be implemented by any classes that can be
 used to retrieve appearance properties for a keyboard.
 
 `KeyboardKit` will automatically create a standard instance
 and bind it to the input view controller when the extension
 is started. You can use it and replace it with a custom one.
 */
public protocol KeyboardAppearance {
    
    var keyboardBackgroundColor: Color { get }
    
    func buttonBackgroundColor(for action: KeyboardAction, isPressed: Bool) -> Color
    func buttonCornerRadius(for action: KeyboardAction) -> CGFloat
    func buttonFont(for action: KeyboardAction) -> Font
    func buttonForegroundColor(for action: KeyboardAction, isPressed: Bool) -> Color
    func buttonImage(for action: KeyboardAction) -> Image?
    func buttonShadowColor(for action: KeyboardAction) -> Color
    func buttonText(for action: KeyboardAction) -> String?
}

//
//  KeyboardAppearance.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit
import SwiftUI

/**
 This protocol can be implemented by any classes that can be
 used to retrieve appearance properties for a keyboard.
 
 `KeyboardKit` will automatically create a standard instance
 and bind it to the input view controller when the extension
 is started. It can be replaced with a custom one by setting
 the `keyboardAppearance` property.
 */
public protocol KeyboardAppearance {
    
    func buttonBackgroundColor(for action: KeyboardAction) -> Color
    func buttonFont(for action: KeyboardAction) -> Font
    func buttonForegroundColor(for action: KeyboardAction) -> Color
    func buttonImage(for action: KeyboardAction) -> Image?
    func buttonShadowColor(for action: KeyboardAction) -> Color
    func buttonText(for action: KeyboardAction) -> String?
}

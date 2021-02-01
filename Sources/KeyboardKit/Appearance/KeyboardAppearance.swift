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
    
    func font(for action: KeyboardAction) -> UIFont
    func fontWeight(for action: KeyboardAction, context: KeyboardContext) -> UIFont.Weight?
    func image(for action: KeyboardAction) -> Image?
    func text(for action: KeyboardAction) -> String?
}

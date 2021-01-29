//
//  KeyboardAppearance.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This protocol can be implemented by any classes that can be
 used to retrieve appearance properties for a keyboard.
 
 KeyboardKit registers a standard protocol implementation in
 the input view controller when the extension is started. It
 can be replaced with a custom implementation by setting the
 `keyboardAppearance` property.
 */
public protocol KeyboardAppearance {
    
    func font(for action: KeyboardAction) -> UIFont
    func fontWeight(for action: KeyboardAction, context: KeyboardContext) -> UIFont.Weight?
    func text(for action: KeyboardAction) -> String?
}

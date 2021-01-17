//
//  KeyboardAppearanceProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This protocol can be implemented by classes or structs that
 can be used to control the appearance of a keyboard.
 
 KeyboardKit registers a standard protocol implementation in
 the keyboard context when the extension is started. You can
 replace this at any time, by applying a new instance to the
 context's `keyboardAppearanceProvider` property.
 
 `IMPORTANT` This is an experimental new feature, that could
 be redesigned in any minor release until 4.0.
 */
public protocol KeyboardAppearanceProvider {
    
    func font(for action: KeyboardAction) -> UIFont
    func fontWeight(for action: KeyboardAction, context: KeyboardContext) -> UIFont.Weight?
    func text(for action: KeyboardAction) -> String?
}

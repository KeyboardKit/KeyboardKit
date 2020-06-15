//
//  KeyboardContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This context implementation provides non-observable context
 properties to the keyboard extension.
 
 This context is used by default, since a observable context
 requires iOS 13.0.
 */
public class StandardKeyboardContext: KeyboardContext {
    
    public init(keyboardType: KeyboardType = .alphabetic(.lowercased)) {
        self.keyboardType = keyboardType
    }
    
    public var keyboardType: KeyboardType
    public var needsInputModeSwitchKey = false
}

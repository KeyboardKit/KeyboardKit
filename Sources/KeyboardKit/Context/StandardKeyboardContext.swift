//
//  KeyboardContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This standard context provides non-observable properties to
 your keyboard extensions.
 
 This context type is used by default by `KeyboardKit`. If a
 keyboard extension targets iOS 13 or later, you can replace
 it with a `ObservableKeyboardContext`.
 */
public class StandardKeyboardContext: KeyboardContext {
    
    public init(
        actionHandler: KeyboardActionHandler,
        keyboardType: KeyboardType) {
        self.actionHandler = actionHandler
        self.keyboardType = keyboardType
    }
    
    public var actionHandler: KeyboardActionHandler
    public var hasFullAccess = false
    public var keyboardType: KeyboardType
    public var needsInputModeSwitchKey = false
}

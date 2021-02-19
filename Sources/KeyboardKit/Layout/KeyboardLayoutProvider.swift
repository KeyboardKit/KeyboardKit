//
//  KeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by classes that can return
 keyboard layouts for the current keyboard state.
 
 `KeyboardKit` will automatically create a standard instance
 and bind it to the input view controller when the extension
 is started. You can use it and replace it with a custom one.
 */
public protocol KeyboardLayoutProvider: AnyObject {
    
    /**
     Get a keyboard layout for the provided context.
     */
    func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout
    
    /**
     Try registering a new input set provider, if the layout
     is based on one.
     */
    func register(inputSetProvider: KeyboardInputSetProvider)
}

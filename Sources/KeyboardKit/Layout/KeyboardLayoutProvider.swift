//
//  KeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any classes that can be
 used to generate a keyboard layout for a certain context.
 */
public protocol KeyboardLayoutProvider: AnyObject {
    
    /**
     Get a keyboard layout for the provided context.
     */
    func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout
    
    /**
     Register a new input set provider.
     */
    func register(inputSetProvider: InputSetProvider)
}

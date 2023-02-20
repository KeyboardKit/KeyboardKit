//
//  StandardKeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This keyboard layout provider returns the layout that it is
 initialized with, without any additional logic.
 */
public class StaticKeyboardLayoutProvider: KeyboardLayoutProvider {
    
    /**
     Create a system keyboard layout provider.
     
     - Parameters:
       - keyboardLayout: The keyboard layout to use.
     */
    public init(
        keyboardLayout: KeyboardLayout
    ) {
        self.layout = keyboardLayout
    }
    
    
    /**
     The keyboard layout to use.
     */
    private let layout: KeyboardLayout
    
    
    /**
     Get a keyboard layout for a certain keyboard context.
     */
    public func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        layout
    }

    /**
     Register a new input set provider.

     This does nothing for a static keyboard layout provider.
     */
    public func register(inputSetProvider: InputSetProvider) {}
}

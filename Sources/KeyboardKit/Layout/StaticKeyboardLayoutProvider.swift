//
//  StandardKeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This keyboard layout provider returns the layout that it is
 initialized with.
 
 It can be used to return a static layout, without taking in
 factors like device and orientation into consideration.
 */
public class StaticKeyboardLayoutProvider: KeyboardLayoutProvider {
    
    public init(keyboardLayout: KeyboardLayout) {
        self.keyboardLayout = keyboardLayout
    }
    
    private let keyboardLayout: KeyboardLayout
    
    public func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        keyboardLayout
    }
}

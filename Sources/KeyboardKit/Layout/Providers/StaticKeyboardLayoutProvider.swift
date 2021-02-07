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
 initialized with, without any additional logic.
 */
public class StaticKeyboardLayoutProvider: KeyboardLayoutProvider {
    
    public init(keyboardLayout: KeyboardLayout) {
        self.layout = keyboardLayout
    }
    
    private let layout: KeyboardLayout
    
    public func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        layout
    }
}

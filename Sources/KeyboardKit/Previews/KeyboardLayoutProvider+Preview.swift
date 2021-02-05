//
//  KeyboardInputSetProvider+Preview.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-25.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This class can be used to preview keyboard views.
 */
public class PreviewKeyboardLayoutProvider: KeyboardLayoutProvider {
    
    public init() {}
    
    public func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        KeyboardLayout(rows: [])
    }
}

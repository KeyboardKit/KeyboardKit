//
//  Keyboard+BackspaceRange.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-05-06.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Keyboard {
    
    /// This enum defines how much the backspace key deletes.
    enum BackspaceRange {
        
        /// Delete a single char at a time.
        case character
        
        /// Delete an entire word at a time.
        case word
        
        /// Delete an entire sentence at a time.
        case sentence
    }
}

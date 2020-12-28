//
//  StandardKeyboardActionBehavior.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This class defines how a standard, Western keyboard behaves.
 
 You can subclass this class and override any implementation
 details you need.
 */
open class StandardKeyboardActionBehavior: KeyboardActionBehavior {
    
    public init() {}
    
    open func shouldChangeToAlphabeticLowercase(after gesture: KeyboardGesture, on action: KeyboardAction, for context: KeyboardContext) -> Bool {
        guard case .alphabetic(.uppercased) = context.keyboardType else { return false }
        guard case .tap = gesture else { return false }
        guard case .character = action else { return false }
        return true
    }
}

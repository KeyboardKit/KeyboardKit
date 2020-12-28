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
    
    public var endSentenceAction: KeyboardAction {
        .character(". ")
    }
    
    open func preferredKeyboardType(after gesture: KeyboardGesture, on action: KeyboardAction, for context: KeyboardContext) -> KeyboardType {
        if shouldSwitchToAlphabeticLowercase(after: gesture, on: action, for: context) { return .alphabetic(.lowercased) }
        return context.keyboardType
    }
    
    open func shouldEndSentence(after gesture: KeyboardGesture, on action: KeyboardAction, for context: KeyboardContext) -> Bool {
        guard let preCursor = context.textDocumentProxy.documentContextBeforeInput else { return false }
        guard preCursor.hasSuffix(" ") else { return false }
        switch action {
        case .space: return true
        case .character(let char): return char == " "
        default: return false
        }
    }
    
    open func shouldSwitchToAlphabeticLowercase(after gesture: KeyboardGesture, on action: KeyboardAction, for context: KeyboardContext) -> Bool {
        guard case .alphabetic(.uppercased) = context.keyboardType else { return false }
        guard case .character = action else { return false }
        return true
    }
}

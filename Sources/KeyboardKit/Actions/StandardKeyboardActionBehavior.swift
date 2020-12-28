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
 You can subclass it and override any parts you need.
 */
open class StandardKeyboardActionBehavior: KeyboardActionBehavior {
    
    public init() {}
    
    public func preferredKeyboardType(after gesture: KeyboardGesture, on action: KeyboardAction, for context: KeyboardContext) -> KeyboardType {
        context.preferredKeyboardType
    }
    
    open func shouldEndSentence(after gesture: KeyboardGesture, on action: KeyboardAction, for context: KeyboardContext) -> Bool {
        let proxy = context.textDocumentProxy
        let isAtEnd = proxy.isCursorAtTheEndOfTheCurrentWord
        let isClosable = (proxy.documentContextBeforeInput ?? "").hasSuffix("  ")
        let shouldClose = isAtEnd && isClosable
        switch action {
        case .space: return shouldClose
        case .character(let char): return char == " " && shouldClose
        default: return false
        }
    }
    
    open func shouldSwitchToPreferredKeyboardType(after gesture: KeyboardGesture, on action: KeyboardAction, for context: KeyboardContext) -> Bool {
        context.keyboardType != context.preferredKeyboardType
    }
}

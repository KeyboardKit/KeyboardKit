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
    
    public init(doubleTapThreshold: TimeInterval = 0.2) {
        self.doubleTapThreshold = doubleTapThreshold
    }
    
    var lastShiftCheck = Date()
    private let doubleTapThreshold: TimeInterval
    
    public func preferredKeyboardType(after gesture: KeyboardGesture, on action: KeyboardAction, for context: KeyboardContext) -> KeyboardType {
        if shouldSwitchToCapsLock(after: gesture, on: action, for: context) { return .alphabetic(.capsLocked) }
        switch action {
        case .shift: return context.keyboardType
        default: return context.preferredKeyboardType
        }
    }
    
    open func shouldEndSentence(after gesture: KeyboardGesture, on action: KeyboardAction, for context: KeyboardContext) -> Bool {
        let proxy = context.textDocumentProxy
        let isNewWord = proxy.isCursorAtNewWord
        let isNewSentence = proxy.isCursorAtNewSentence
        let isClosable = (proxy.documentContextBeforeInput ?? "").hasSuffix("  ")
        let shouldClose = isNewWord && !isNewSentence && isClosable
        switch action {
        case .space: return shouldClose
        case .character(let char): return char == " " && shouldClose
        default: return false
        }
    }
    
    open func shouldSwitchToCapsLock(after gesture: KeyboardGesture, on action: KeyboardAction, for context: KeyboardContext) -> Bool {
        guard action.isShift else { return false }
        guard context.keyboardType.isAlphabetic else { return false }
        let isDoubleTap = Date().timeIntervalSinceReferenceDate - lastShiftCheck.timeIntervalSinceReferenceDate < doubleTapThreshold
        lastShiftCheck = Date()
        return isDoubleTap
    }
    
    open func shouldSwitchToPreferredKeyboardType(after gesture: KeyboardGesture, on action: KeyboardAction, for context: KeyboardContext) -> Bool {
        switch action {
        case .shift: return true
        default: return context.keyboardType != context.preferredKeyboardType
        }
    }
}

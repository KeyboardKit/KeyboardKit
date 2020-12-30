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
    
    public func preferredKeyboardType(for context: KeyboardContext, after gesture: KeyboardGesture, on action: KeyboardAction) -> KeyboardType {
        if shouldSwitchToCapsLock(for: context, after: gesture, on: action) { return .alphabetic(.capsLocked) }
        switch action {
        case .shift: return context.keyboardType
        default: return context.preferredKeyboardType
        }
    }
    
    open func shouldEndSentence(for context: KeyboardContext, after gesture: KeyboardGesture, on action: KeyboardAction) -> Bool {
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
    
    open func shouldSwitchToCapsLock(for context: KeyboardContext, after gesture: KeyboardGesture, on action: KeyboardAction) -> Bool {
        guard action.isShift else { return false }
        guard context.keyboardType.isAlphabetic else { return false }
        let isDoubleTap = Date().timeIntervalSinceReferenceDate - lastShiftCheck.timeIntervalSinceReferenceDate < doubleTapThreshold
        lastShiftCheck = Date()
        return isDoubleTap
    }
    
    open func shouldSwitchToPreferredKeyboardType(for context: KeyboardContext, after gesture: KeyboardGesture, on action: KeyboardAction) -> Bool {
        switch action {
        case .shift: return true
        default: return context.keyboardType != context.preferredKeyboardType
        }
    }
}

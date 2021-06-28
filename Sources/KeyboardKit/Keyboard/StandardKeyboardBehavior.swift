//
//  StandardKeyboardBehavior.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This class defines how a standard, Western keyboard behaves.
 
 This class makes heavy use of default logic in for instance
 the text document proxy. However, having this makes it easy
 to change the actual behavior, if you want or need to.
 
 You can inherit this class and override any open properties
 and functions to customize the standard behavior.
 
 `NOTE` This class handles `shift` a bit different, since it
 must handle double taps to switch to caps lock. Due to this,
 it must not switch to the preferred keyboard, but must also
 always try to do so. This behavior is tested to ensure that
 is is behaving as it should, although it may be hard to see
 why the code is the way it is.
 */
open class StandardKeyboardBehavior: KeyboardBehavior {
    
    public init(
        context: KeyboardContext,
        timer: RepeatGestureTimer = .shared,
        doubleTapThreshold: TimeInterval = 0.2,
        endSentenceThreshold: TimeInterval = 3.0) {
        self.context = context
        self.doubleTapThreshold = doubleTapThreshold
        self.endSentenceThreshold = endSentenceThreshold
        self.timer = timer
    }
    
    private let context: KeyboardContext
    private let doubleTapThreshold: TimeInterval
    private let endSentenceThreshold: TimeInterval
    private let timer: RepeatGestureTimer
    
    var lastShiftCheck = Date()
    var lastSpaceTap = Date()
    
    public var backspaceRange: DeleteBackwardRange {
        let duration = timer.duration ?? 0
        return duration > 3 ? .word : .char
    }
    
    public func preferredKeyboardType(
        after gesture: KeyboardGesture,
        on action: KeyboardAction) -> KeyboardType {
        if shouldSwitchToCapsLock(after: gesture, on: action) { return .alphabetic(.capsLocked) }
        let should = shouldSwitchToPreferredKeyboardType(after: gesture, on: action)
        switch action {
        case .shift: return context.keyboardType
        default: return should ? context.preferredKeyboardType : context.keyboardType
        }
    }
    
    open func shouldEndSentence(
        after gesture: KeyboardGesture,
        on action: KeyboardAction) -> Bool {
        guard gesture == .tap, action == .space else { return false }
        let proxy = context.textDocumentProxy
        let isNewWord = proxy.isCursorAtNewWord
        let isNewSentence = proxy.isCursorAtNewSentence
        let isClosable = (proxy.documentContextBeforeInput ?? "").hasSuffix("  ")
        let isEndingTap = Date().timeIntervalSinceReferenceDate - lastSpaceTap.timeIntervalSinceReferenceDate < endSentenceThreshold
        let shouldClose = isEndingTap && isNewWord && !isNewSentence && isClosable
        lastSpaceTap = Date()
        return shouldClose
    }
    
    open func shouldSwitchToCapsLock(
        after gesture: KeyboardGesture,
        on action: KeyboardAction) -> Bool {
        switch action {
        case .shift: return isDoubleShiftTap
        default: return false
        }
    }
    
    open func shouldSwitchToPreferredKeyboardType(
        after gesture: KeyboardGesture,
        on action: KeyboardAction) -> Bool {
        switch action {
        case .keyboardType: return false
        case .shift: return true
        default: return gesture == .tap && context.keyboardType != context.preferredKeyboardType
        }
    }
    
    public func shouldSwitchToPreferredKeyboardTypeAfterTextDidChange() -> Bool {
        context.keyboardType != context.preferredKeyboardType
    }
}

private extension StandardKeyboardBehavior {
    
    var isDoubleShiftTap: Bool {
        guard context.keyboardType.isAlphabetic else { return false }
        let isDoubleTap = Date().timeIntervalSinceReferenceDate - lastShiftCheck.timeIntervalSinceReferenceDate < doubleTapThreshold
        lastShiftCheck = Date()
        return isDoubleTap
    }
}

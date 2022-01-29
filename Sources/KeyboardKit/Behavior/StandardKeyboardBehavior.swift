//
//  StandardKeyboardBehavior.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import Foundation

/**
 This class defines how a standard, Western keyboard behaves.
 
 You can inherit this class and override any open properties
 and functions to customize the standard behavior.
 
 This class makes heavy use of standard logic that's defined
 elsewhere. However, having this makes it easy to change the
 actual behavior.
 
 `NOTE` This class handles `shift` a bit different, since it
 must handle double taps to switch to caps lock. Due to this,
 it must not switch to the preferred keyboard, but must also
 always try to do so. This behavior is tested to ensure that
 is is behaving as it should, although it may be hard to see
 why the code is the way it is.
 */
open class StandardKeyboardBehavior: KeyboardBehavior {
    
    /**
      Create a standard keybaord behavior instance.
     
      - Parameters:
        - context: The keyboard context to use.
        - doubleTapThreshold: The second threshold to detect a tap as a double tap.
        - endSentenceThreshold: The second threshold during which a sentence can be auto-closed.
        - repeatGestureTimer: A timer that is responsible for triggering a repeat gesture action.
     */
    public init(
        context: KeyboardContext,
        doubleTapThreshold: TimeInterval = 0.2,
        endSentenceThreshold: TimeInterval = 3.0,
        repeatGestureTimer: RepeatGestureTimer = .shared) {
        self.context = context
        self.doubleTapThreshold = doubleTapThreshold
        self.endSentenceThreshold = endSentenceThreshold
        self.repeatGestureTimer = repeatGestureTimer
    }
    
    
    private let context: KeyboardContext
    private let doubleTapThreshold: TimeInterval
    private let endSentenceThreshold: TimeInterval
    private let repeatGestureTimer: RepeatGestureTimer
    
    var lastShiftCheck = Date()
    var lastSpaceTap = Date()
    
    
    /**
    The range that the backspace key should delete when the
    key is long pressed.
    */
    public var backspaceRange: DeleteBackwardRange {
        let duration = repeatGestureTimer.duration ?? 0
        return duration > 3 ? .word : .char
    }
    
    /**
     The preferred keyboard type that should be applied when
     a certain gesture has been performed on an action.
     */
    public func preferredKeyboardType(
        after gesture: KeyboardGesture,
        on action: KeyboardAction) -> KeyboardType {
        if shouldSwitchToCapsLock(after: gesture, on: action) { return .alphabetic(.capsLocked) }
        if action.isAlternateQuotationDelimiter(for: context) { return .alphabetic(.lowercased) }
        let should = shouldSwitchToPreferredKeyboardType(after: gesture, on: action)
        switch action {
        case .shift: return context.keyboardType
        default: return should ? context.preferredKeyboardType : context.keyboardType
        }
    }
    
    /**
     Whether or not to end the currently typed sentence when
     a certain gesture has been performed on an action.
     */
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
    
    /**
     Whether or not to switch to capslock when a gesture has
     been performed on an action.
     */
    open func shouldSwitchToCapsLock(
        after gesture: KeyboardGesture,
        on action: KeyboardAction) -> Bool {
        switch action {
        case .shift: return isDoubleShiftTap
        default: return false
        }
    }
    
    /**
     Whether or not to switch to the preferred keyboard type
     when a certain gesture has been performed on an action.
     */
    open func shouldSwitchToPreferredKeyboardType(
        after gesture: KeyboardGesture,
        on action: KeyboardAction) -> Bool {
        // if action.isAlternateQuotationDelimiter(for: context) { return true }
        switch action {
        case .keyboardType(let type): return type.shouldSwitchToPreferredKeyboardType
        case .shift: return true
        default: return gesture == .tap && context.keyboardType != context.preferredKeyboardType
        }
    }
    
    /**
     Whether or not to switch to the preferred keyboard type
     after the text document proxy text did change.
     */
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

private extension KeyboardAction {
    
    func isAlternateQuotationDelimiter(for context: KeyboardContext) -> Bool {
        switch self {
        case .character(let char): return char.isAlternateQuotationDelimiter(for: context)
        default: return false
        }
    }
}

private extension String {
    
    func isAlternateQuotationDelimiter(for context: KeyboardContext) -> Bool {
        let locale = context.locale
        return self == locale.alternateQuotationBeginDelimiter || self == locale.alternateQuotationEndDelimiter
    }
}

private extension KeyboardType {
    
    var shouldSwitchToPreferredKeyboardType: Bool {
        switch self {
        case .alphabetic(let state): return state.shouldSwitchToPreferredKeyboardType
        default: return false
        }
    }
}


private extension KeyboardCasing {
    
    var shouldSwitchToPreferredKeyboardType: Bool {
        switch self {
        case .auto: return true
        default: return false
        }
    }
}
#endif

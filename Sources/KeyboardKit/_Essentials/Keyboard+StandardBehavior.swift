//
//  KeyboardBehavior+Standard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

extension Keyboard {
    
    /// This class defines the standard keyboard behavior of
    /// a standard western keyboard, with some locale tweaks.
    ///
    /// Note that this class handles `shift` a bit different,
    /// since it must handle double taps for caps lock.
    ///
    /// KeyboardKit automatically creates an instance of the
    /// class when the keyboard is launched, then injects it
    /// into ``KeyboardInputViewController/services``.
    ///
    /// You can inherit this class to get base functionality,
    /// then override any open parts that you want to change.
    open class StandardBehavior: KeyboardBehavior {
        
        /// Create a standard keyboard behavior instance.
        ///
        /// - Parameters:
        ///   - keyboardContext: The keyboard context to use.
        ///   - doubleTapThreshold: The douple tap threshold to use, by default `0.5` seconds.
        ///   - endSentenceText: The text to use to end sentences with, by default `. `.
        ///   - endSentenceThreshold: The end sentence auto-close threshold to use, by default `3.0` seconds.
        ///   - repeatGestureTimer: The repease gesture timer to use, by default ``Gestures/RepeatTimer/shared``.
        public init(
            keyboardContext: KeyboardContext,
            doubleTapThreshold: TimeInterval = 0.5,
            endSentenceText: String = ". ",
            endSentenceThreshold: TimeInterval = 3.0,
            repeatGestureTimer: Gestures.RepeatTimer = .shared
        ) {
            self.keyboardContext = keyboardContext
            self.doubleTapThreshold = doubleTapThreshold
            self.endSentenceText = endSentenceText
            self.endSentenceThreshold = endSentenceThreshold
            self.repeatGestureTimer = repeatGestureTimer
        }
        
        
        /// The keyboard context to use.
        public let keyboardContext: KeyboardContext
        
        /// The douple tap threshold to use.
        public let doubleTapThreshold: TimeInterval

        /// The text to use to end sentences with.
        public var endSentenceText: String

        /// The end sentence auto-close threshold to use.
        public let endSentenceThreshold: TimeInterval
        
        /// The repease gesture timer to use.
        public let repeatGestureTimer: Gestures.RepeatTimer
        
        
        /// An internal state to keep track of shift checks.
        public internal(set) var lastShiftCheck = Date()
        
        /// An internal state to keep track of the last space tap.
        public internal(set) var lastSpaceTap = Date()
        
        
        // MARK: - KeyboardBehavior
        
        /// The range that backspace should delete.
        open var backspaceRange: Keyboard.BackspaceRange {
            let duration = repeatGestureTimer.duration ?? 0
            return duration > 3 ? .word : .character
        }
        
        /// The preferred keyboard type after an action gesture.
        open func preferredKeyboardType(
            after gesture: Gesture,
            on action: KeyboardAction
        ) -> Keyboard.KeyboardType {
            if shouldSwitchToCapsLock(after: gesture, on: action) { return .alphabetic(.capsLocked) }
            if action.isAlternateQuotationDelimiter(for: keyboardContext) { return .alphabetic(.lowercased) }
            let should = shouldSwitchToPreferredKeyboardType(after: gesture, on: action)
            switch action {
            case .shift: return keyboardContext.keyboardType
            default: return should ? keyboardContext.preferredKeyboardType : keyboardContext.keyboardType
            }
        }
        
        /// Whether to end the sentence after a gesture action.
        open func shouldEndSentence(
            after gesture: Gesture,
            on action: KeyboardAction
        ) -> Bool {
#if os(iOS) || os(tvOS) || os(visionOS)
            guard gesture == .release, action == .space else { return false }
            let proxy = keyboardContext.textDocumentProxy
            let isNewWord = proxy.isCursorAtNewWord
            let isNewSentence = proxy.isCursorAtNewSentence
            let isClosable = (proxy.documentContextBeforeInput ?? "").hasSuffix("  ")
            let isEndingTap = Date().timeIntervalSinceReferenceDate - lastSpaceTap.timeIntervalSinceReferenceDate < endSentenceThreshold
            let shouldClose = isEndingTap && isNewWord && !isNewSentence && isClosable
            lastSpaceTap = Date()
            return shouldClose
#else
            return false
#endif
        }
        
        /// Whether to switch to capslock after a gesture action.
        open func shouldSwitchToCapsLock(
            after gesture: Gesture,
            on action: KeyboardAction
        ) -> Bool {
            switch action {
            case .shift: isDoubleShiftTap
            default: false
            }
        }
        
        /// Whether to switch to the preferred keyboard type after
        /// a gesture action.
        open func shouldSwitchToPreferredKeyboardType(
            after gesture: Gesture,
            on action: KeyboardAction
        ) -> Bool {
            // if action.isAlternateQuotationDelimiter(for: context) { return true }
            switch action {
            case .backspace: isPreferredKeyboardDifferent
            case .keyboardType(let type): type.shouldSwitchToPreferredKeyboardType
            case .shift: true
            default: gesture == .release && isPreferredKeyboardDifferent
            }
        }
        
        /// Whether to switch to a preferred keyboard type after
        /// the text document proxy text changes.
        public func shouldSwitchToPreferredKeyboardTypeAfterTextDidChange() -> Bool {
            isPreferredKeyboardDifferent
        }
    }
}

public extension Keyboard.StandardBehavior {
    
    /// Is the preferred keyboard different from the current.
    var isPreferredKeyboardDifferent: Bool {
        let current = keyboardContext.keyboardType
        let preferred = keyboardContext.preferredKeyboardType
        return current != preferred
    }
    
    /// Is the type currently registering a double shift tap.
    var isDoubleShiftTap: Bool {
        guard keyboardContext.keyboardType.isAlphabetic else { return false }
        let date = Date().timeIntervalSinceReferenceDate
        let lastDate = lastShiftCheck.timeIntervalSinceReferenceDate
        let isDoubleTap = (date - lastDate) < doubleTapThreshold
        lastShiftCheck = isDoubleTap ? Date().addingTimeInterval(-1) : Date()
        return isDoubleTap
    }
}

private extension KeyboardAction {
    
    func isAlternateQuotationDelimiter(for context: KeyboardContext) -> Bool {
        switch self {
        case .character(let char): char.isAlternateQuotationDelimiter(for: context)
        default: false
        }
    }
}

private extension String {
    
    func isAlternateQuotationDelimiter(for context: KeyboardContext) -> Bool {
        let locale = context.locale
        return self == locale.alternateQuotationBeginDelimiter || self == locale.alternateQuotationEndDelimiter
    }
}

private extension Keyboard.KeyboardType {
    
    var shouldSwitchToPreferredKeyboardType: Bool {
        switch self {
        case .alphabetic(let state): state.shouldSwitchToPreferredKeyboardType
        default: false
        }
    }
}

private extension Keyboard.Case {
    
    var shouldSwitchToPreferredKeyboardType: Bool {
        switch self {
        case .auto: true
        default: false
        }
    }
}

//
//  StaticKeyboardBehavior.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-01-19.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This behavior can be used to define a behavior that doesn't
 cause any changes to the keyboard when typing.
 
 This behavior is used where ``StandardKeyboardBehavior`` is
 not available.
 */
public class StaticKeyboardBehavior: KeyboardBehavior {
    
    
    public init(context: KeyboardContext) {
        self.context = context
    }
    
    
    private let context: KeyboardContext
    
    
    /**
     The range that the backspace key should delete when the
     key is long pressed.
     */
    public var backspaceRange: DeleteBackwardRange { .char }
    
    /**
     The preferred keyboard type that should be applied when
     a certain gesture has been performed on an action.
     */
    public func preferredKeyboardType(
        after gesture: KeyboardGesture,
        on action: KeyboardAction) -> KeyboardType {
        context.keyboardType
    }
    
    /**
     Whether or not to end the currently typed sentence when
     a certain gesture has been performed on an action.
     */
    public func shouldEndSentence(
        after gesture: KeyboardGesture,
        on action: KeyboardAction) -> Bool {
        false
    }
    
    /**
     Whether or not to switch to capslock when a gesture has
     been performed on an action.
     */
    public func shouldSwitchToCapsLock(
        after gesture: KeyboardGesture,
        on action: KeyboardAction) -> Bool {
        false
    }
    
    /**
     Whether or not to switch to the preferred keyboard type
     when a certain gesture has been performed on an action.
     */
    public func shouldSwitchToPreferredKeyboardType(
        after gesture: KeyboardGesture,
        on action: KeyboardAction) -> Bool {
        false
    }
    
    /**
     Whether or not to switch to the preferred keyboard type
     after the text document proxy text did change.
     */
    public func shouldSwitchToPreferredKeyboardTypeAfterTextDidChange() -> Bool {
        false
    }
}

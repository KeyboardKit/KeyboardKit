//
//  StaticKeyboardBehavior.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-01-19.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This behavior can be used to define a behavior that doesn't
 cause any changes to the keyboard when typing.
 
 This behavior is used where ``StandardKeyboardBehavior`` is
 not available.
 */
open class StaticKeyboardBehavior: KeyboardBehavior {

    /**
      Create a static keyboard behavior instance.

      - Parameters:
        - keyboardContext: The keyboard context to use.
     */
    public init(keyboardContext: KeyboardContext) {
        self.keyboardContext = keyboardContext
    }


    /// The keyboard context to use.
    private let keyboardContext: KeyboardContext
    
    
    /**
     The range that the backspace key should delete when the
     key is long pressed.
     */
    open var backspaceRange: DeleteBackwardRange { .character }
    
    /**
     The preferred keyboard type that should be applied when
     a certain gesture has been performed on an action.
     */
    open func preferredKeyboardType(
        after gesture: KeyboardGesture,
        on action: KeyboardAction
    ) -> KeyboardType {
        keyboardContext.keyboardType
    }
    
    /**
     Whether or not to end the currently typed sentence when
     a certain gesture has been performed on an action.
     */
    open func shouldEndSentence(
        after gesture: KeyboardGesture,
        on action: KeyboardAction
    ) -> Bool {
        false
    }
    
    /**
     Whether or not to switch to capslock when a gesture has
     been performed on an action.
     */
    open func shouldSwitchToCapsLock(
        after gesture: KeyboardGesture,
        on action: KeyboardAction
    ) -> Bool {
        false
    }
    
    /**
     Whether or not to switch to the preferred keyboard type
     when a certain gesture has been performed on an action.
     */
    open func shouldSwitchToPreferredKeyboardType(
        after gesture: KeyboardGesture,
        on action: KeyboardAction
    ) -> Bool {
        false
    }
    
    /**
     Whether or not to switch to the preferred keyboard type
     after the text document proxy text did change.
     */
    open func shouldSwitchToPreferredKeyboardTypeAfterTextDidChange() -> Bool {
        false
    }
}

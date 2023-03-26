//
//  KeyboardBehavior.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be used to specify behavior rules for the
 keyboard. It aims to separate behavior from action handling
 to make the code cleaner and more understandable.
 
 `IMPORTANT` Whenever you replace the standard behavior with
 your own custom behavior, make sure to do so before calling
 any other services that depend on the behavior, or recreate
 the services that do depend on it.
 */
public protocol KeyboardBehavior {
    
    /**
     The range that the backspace key should delete when the
     key is long pressed.
     */
    var backspaceRange: DeleteBackwardRange { get }
    
    /**
     The preferred keyboard type that should be applied when
     a certain gesture has been performed on an action.
     */
    func preferredKeyboardType(
        after gesture: KeyboardGesture,
        on action: KeyboardAction
    ) -> KeyboardType
    
    /**
     Whether or not to end the currently typed sentence when
     a certain gesture has been performed on an action.
     */
    func shouldEndSentence(
        after gesture: KeyboardGesture,
        on action: KeyboardAction
    ) -> Bool
    
    /**
     Whether or not to switch to capslock when a gesture has
     been performed on an action.
     */
    func shouldSwitchToCapsLock(
        after gesture: KeyboardGesture,
        on action: KeyboardAction
    ) -> Bool
    
    /**
     Whether or not to switch to the preferred keyboard type
     when a certain gesture has been performed on an action.
     */
    func shouldSwitchToPreferredKeyboardType(
        after gesture: KeyboardGesture,
        on action: KeyboardAction
    ) -> Bool

    /**
     Whether or not to switch to the preferred keyboard type
     after the text document proxy text did change.
     */
    func shouldSwitchToPreferredKeyboardTypeAfterTextDidChange() -> Bool
}

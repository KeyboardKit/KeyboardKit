//
//  KeyboardBehavior.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be used to specify behavior rules for the
 keyboard. It aims to separate behavior from action handling
 to make the code cleaner, flexible and more understandable.
 
 This protocol can be extended with new functionality in any
 minor release. To avoid breaking changes, you could inherit
 `StandardKeyboardBehavior` then override any parts you need,
 instead of creating a completely new class.
 */
public protocol KeyboardBehavior {
    
    /**
     The preferred keyboard type that should be applied when
     the provided action has been performed.
     */
    func preferredKeyboardType(for context: KeyboardContext, after gesture: KeyboardGesture, on action: KeyboardAction) -> KeyboardType
    
    /**
     Whether or not the active sentence should be ended when
     the provided action has been performed.
     */
    func shouldEndSentence(for context: KeyboardContext, after gesture: KeyboardGesture, on action: KeyboardAction) -> Bool
    
    /**
     Whether or not the current keyboard type should be auto
     switched to the behavior's preferred keyboard type when
     the provided action has been performed.
     */
    func shouldSwitchToPreferredKeyboardType(for context: KeyboardContext, after gesture: KeyboardGesture, on action: KeyboardAction) -> Bool

    /**
     Whether or not the current keyboard type should be auto
     switched to the behavior's preferred keyboard type when
     the text document proxy's text did change.
     */
    func shouldSwitchToPreferredKeyboardTypeAfterTextDidChange(for context: KeyboardContext) -> Bool
}

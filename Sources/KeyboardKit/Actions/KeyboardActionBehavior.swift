//
//  KeyboardActionBehavior.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be used to specify behavior rules for how
 various keyboard actions should behave. It aims to separate
 action handling from action behavior to make the api design
 cleaner, more flexible and more understandable.
 
 This protocol can be extended with new functionality in any
 minor release. To avoid breaking changes, you could inherit
 `StandardKeyboardActionBehavior` and override any parts you
 need to change, instead of creating a completely new class.
 */
public protocol KeyboardActionBehavior {
    
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
}

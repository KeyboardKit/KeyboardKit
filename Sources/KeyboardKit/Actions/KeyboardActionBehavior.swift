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
 cleaner and more understandable.
 
 This protocol can be extended with new functionality in any
 minor release. To avoid breaking changes, you could inherit
 `StandardKeyboardActionBehavior` and override any parts you
 need to change, instead of creating a completely new class.
 */
public protocol KeyboardActionBehavior {
    
    var endSentenceAction: KeyboardAction { get }
    
    func shouldEndSentence(after gesture: KeyboardGesture, on action: KeyboardAction, for context: KeyboardContext) -> Bool
    func shouldSwitchToAlphabeticLowercase(after gesture: KeyboardGesture, on action: KeyboardAction, for context: KeyboardContext) -> Bool
}

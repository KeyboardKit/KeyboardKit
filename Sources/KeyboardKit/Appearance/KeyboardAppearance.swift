//
//  KeyboardAppearance.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import SwiftUI

/**
 This protocol can be implemented by classes that can define
 styles and appearances for keyboard actions.
 
 Unlike a style, appearances are contextual and more complex.
 You can use appearances to generate styles that can then be
 applied to various parts of a keyboard.
 */
public protocol KeyboardAppearance: AnyObject {
    
    /**
     The style to apply when presenting an ``ActionCallout``.
     */
    func actionCalloutStyle() -> ActionCalloutStyle
    
    /**
     The button image to use for a certain `action`, if any.
     */
    func buttonImage(for action: KeyboardAction) -> Image?
    
    /**
     The button text to use for a certain `action`, if any.
     */
    func buttonText(for action: KeyboardAction) -> String?
    
    /**
     The style to apply when presenting an ``InputCallout``.
     */
    func inputCalloutStyle() -> InputCalloutStyle
    
    /**
     The system keybard button style to use for the provided
     `action` given a certain `isPressed` state.
     */
    func systemKeyboardButtonStyle(for action: KeyboardAction, isPressed: Bool) -> SystemKeyboardButtonStyle
}

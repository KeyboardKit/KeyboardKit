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
 This protocol can be implemented by any classes that can be
 used to provide appearance information for keyboard actions.
 
 Unlike a style, an appearance is contextual. It requires an
 implementation, while a style is just a struct. You can use
 an appearance to generate styles that can be applied to the
 keyboard and its buttons.
 
 KeyboardKit automatically creates an implementation of this
 protocol and binds it to ``KeyboardInputViewController``.
 
 `TODO` From KeyboardKit 6.0, the various styles will be put
 into a single `SystemKeyboardStyle` property, so that it is
 easy to just return `.standard` in custom appearances.
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

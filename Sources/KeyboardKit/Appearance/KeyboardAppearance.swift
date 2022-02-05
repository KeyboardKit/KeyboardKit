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
 styles and appearances for different parts of a keyboard.
 
 Many views in the library use an appearance if they have to
 be able to generate different styles. This is true for e.g.
 ``SystemKeyboard``, which renders many different components
 and buttons. Views that only need to be styled in a certain
 way can just ask for a fixed style instead of an appearance.
 
 KeyboardKit will create a ``StandardKeyboardAppearance`` as
 the keyboard extension is started, then apply this instance
 to ``KeyboardInputViewController/keyboardAppearance``. This
 instance will then be used by default to determine how your
 appearance-based views will look.
 
 If you want to change the style of some buttons or callouts
 or change the the text or image to use for buttons, you can
 implement a custom keyboard appearance.
 
 You can create a custom implementation of this protocol, by
 either inheriting and customizing the standard class (which
 gives you a lot of functionality for free) or by creating a
 new implementation from scratch. When you're implementation
 is ready, just replace the controller service with your own
 implementation to make the library use it instead.
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
     The button style to use for a certain `action`, given a
     certain `isPressed` state.
     */
    func buttonStyle(for action: KeyboardAction, isPressed: Bool) -> KeyboardButtonStyle
    
    /**
     The button text to use for a certain `action`, if any.
     */
    func buttonText(for action: KeyboardAction) -> String?
    
    /**
     The style to apply when presenting an ``InputCallout``.
     */
    func inputCalloutStyle() -> InputCalloutStyle
}

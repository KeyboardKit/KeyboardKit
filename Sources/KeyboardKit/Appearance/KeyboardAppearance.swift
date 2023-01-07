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
 
 KeyboardKit will create a ``StandardKeyboardAppearance`` as
 the keyboard extension is started, then apply this instance
 to ``KeyboardInputViewController/keyboardAppearance``. This
 instance will then be used by default to determine how your
 appearance-based views will look.
 
 If you want to change the style of some buttons or callouts
 or change the the text or image to use for buttons, you can
 implement a custom keyboard appearance.

 You can create a custom implementation of this protocol, by
 inheriting and customizing the standard class or creating a
 new implementation from scratch. When you're implementation
 is ready, just replace the controller service with your own
 implementation to make the library use it instead.
 */
public protocol KeyboardAppearance: AnyObject {

    /**
     The edge insets to apply to the entire keyboard.
     */
    var keyboardEdgeInsets: EdgeInsets { get }
    
    /**
     The style to apply when presenting an ``ActionCallout``.

     > Note: This will be turned to a property in KK7 (TODO)
     */
    func actionCalloutStyle() -> ActionCalloutStyle
    
    /**
     The button image to use for a certain `action`, if any.
     */
    func buttonImage(for action: KeyboardAction) -> Image?

    /**
     The scale factor to apply to a button image, if any.
     */
    func buttonImageScaleFactor(for action: KeyboardAction) -> CGFloat
    
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

     > Note: This will be turned to a property in KK7 (TODO)
     */
    func inputCalloutStyle() -> InputCalloutStyle
}

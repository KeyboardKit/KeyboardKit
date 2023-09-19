//
//  KeyboardStyleProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import SwiftUI

/**
 This protocol can be implemented by classes that can define
 styles for different parts of a keyboard.
 
 KeyboardKit will create a ``StandardKeyboardStyleProvider``
 instance when the keyboard extension is started, then apply
 it to ``KeyboardInputViewController/keyboardStyleProvider``.
 This instance is then used by default to determine how your
 keyboard looks if you use a standard ``SystemKeyboard``.
 
 To change the style of some parts of your keyboard, you can
 implement a custom keyboard style provider.

 To create a custom implementation of this protocol, you can
 implement it from scratch or inherit the standard class and
 override the parts that you want to change. When the custom
 implementation is done, you can just replace the controller
 service to make KeyboardKit use the custom service globally.
 */
public protocol KeyboardStyleProvider: AnyObject {

    /// The background style to apply to the entire keyboard.
    var backgroundStyle: KeyboardStyle.Background { get }

    /// The foreground color to apply to the entire keyboard.
    var foregroundColor: Color? { get }

    /// The edge insets to apply to the entire keyboard.
    var keyboardEdgeInsets: EdgeInsets { get }


    // MARK: - Buttons
    
    /// The button content bottom margin for an action.
    func buttonContentBottomMargin(for action: KeyboardAction) -> CGFloat

    /// The button image to use for a certain action.
    func buttonImage(for action: KeyboardAction) -> Image?

    /// The scale factor to apply to a button image.
    func buttonImageScaleFactor(for action: KeyboardAction) -> CGFloat
    
    /// The button style to use for a certain action.
    func buttonStyle(for action: KeyboardAction, isPressed: Bool) -> KeyboardStyle.Button
    
    /// The button text to use for a certain action.
    func buttonText(for action: KeyboardAction) -> String?


    // MARK: - Callouts

    /// The style to apply to ``ActionCallout`` views.
    var actionCalloutStyle: KeyboardStyle.ActionCallout { get }
    
    /// The style to apply to ``InputCallout`` views.
    var inputCalloutStyle: KeyboardStyle.InputCallout { get }


    // MARK: - Callouts

    /// The style to use for ``Autocomplete/Toolbar`` views.
    var autocompleteToolbarStyle: KeyboardStyle.AutocompleteToolbar { get }
}

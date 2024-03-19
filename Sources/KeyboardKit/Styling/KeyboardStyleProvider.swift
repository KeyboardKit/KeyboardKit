//
//  KeyboardStyleProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import SwiftUI

/**
 This protocol can be implemented by classes that can define
 styles for different parts of a keyboard.
 
 KeyboardKit will register a ``StandardKeyboardStyleProvider``
 with ``KeyboardInputViewController/services``. It will then
 be used as the default style provider.
 
 To change the style of some parts of your keyboard, you can
 implement a custom style provider.
 
 To create a custom implementation of this protocol, you can
 either implement the protocol from scratch, or subclass the
 standard class and override what you want to change. Inject
 it into ``KeyboardInputViewController/services`` to make it
 be used as the global default.
 */
public protocol KeyboardStyleProvider: AnyObject {

    /// The background style to apply to the entire keyboard.
    var backgroundStyle: Keyboard.Background { get }

    /// The foreground color to apply to the entire keyboard.
    var foregroundColor: Color? { get }

    /// The edge insets to apply to the entire keyboard.
    var keyboardEdgeInsets: EdgeInsets { get }


    // MARK: - Buttons
    
    /// The overall insets action's content.
    func buttonContentInsets(for action: KeyboardAction) -> EdgeInsets

    /// The additional bottom margin for an action's content.
    func buttonContentBottomMargin(for action: KeyboardAction) -> CGFloat

    /// The button image to use for a certain action.
    func buttonImage(for action: KeyboardAction) -> Image?

    /// The scale factor to apply to a button image.
    func buttonImageScaleFactor(for action: KeyboardAction) -> CGFloat
    
    /// The button style to use for a certain action.
    func buttonStyle(for action: KeyboardAction, isPressed: Bool) -> KeyboardButton.ButtonStyle
    
    /// The button text to use for a certain action.
    func buttonText(for action: KeyboardAction) -> String?


    // MARK: - Callouts

    /// The style to use on ``Callouts/ActionCallout`` views.
    var actionCalloutStyle: KeyboardStyle.ActionCallout { get }
    
    /// The style to use on ``Callouts/InputCallout`` views.
    var inputCalloutStyle: KeyboardStyle.InputCallout { get }


    // MARK: - Callouts

    /// The style to use for ``Autocomplete/Toolbar`` views.
    var autocompleteToolbarStyle: Autocomplete.ToolbarStyle { get }
}

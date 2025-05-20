//
//  KeyboardStyleService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import SwiftUI

/// This protocol can be implemented by any classes that can
/// provide dynamic keyboard styles.
///
/// While most views in the library have view modifiers that
/// apply their specific styles, some views are more complex
/// and require more dynamic styling.
///
/// For instance, the ``KeyboardView`` embeds many different
/// components like the ``EmojiKeyboard`` which define their
/// own styles. For now, this service generates these styles,
/// which means that a view rendered within a ``KeyboardView``
/// can't be styled with their dedicated view modifiers.
///
/// KeyboardKit will automatically setup a standard protocol
/// implementation in ``KeyboardInputViewController/services``
/// when the keyboard is launched. You can change or replace
/// it at any time to customize the keyboard action behavior.
public protocol KeyboardStyleService: AnyObject {

    /// The background style to apply to the entire keyboard.
    var backgroundStyle: Keyboard.Background { get }

    /// The foreground color to apply to the entire keyboard.
    var foregroundColor: Color? { get }

    /// The edge insets to apply to the entire keyboard.
    var keyboardEdgeInsets: EdgeInsets { get }


    // MARK: - Buttons
    
    /// The overall insets action's content.
    func buttonContentInsets(for action: KeyboardAction) -> EdgeInsets

    /// The button image to use for a certain action.
    func buttonImage(for action: KeyboardAction) -> Image?

    /// The scale factor to apply to a button image.
    func buttonImageScaleFactor(for action: KeyboardAction) -> CGFloat
    
    /// The button style to use for a certain action.
    func buttonStyle(for action: KeyboardAction, isPressed: Bool) -> Keyboard.ButtonStyle
    
    /// The button text to use for a certain action.
    func buttonText(for action: KeyboardAction) -> String?


    // MARK: - Autocomplete

    /// The style to use for ``Autocomplete/Toolbar`` views.
    var autocompleteToolbarStyle: Autocomplete.ToolbarStyle { get }


    // MARK: - Callouts

    /// The callout style to override the standard style with, if any.
    var calloutStyle: KeyboardCallout.CalloutStyle? { get }
}

public extension KeyboardStyleService {

    /// The keyboard view style to apply.
    var keyboardViewStyle: KeyboardViewStyle {
        .init(
            background: backgroundStyle,
            foregroundColor: foregroundColor,
            edgeInsets: keyboardEdgeInsets
        )
    }
}

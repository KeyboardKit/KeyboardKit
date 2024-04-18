//
//  SystemKeyboardComponent.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-04-18.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This protocol can be implemented by view components that
/// can render a whole or parts of a system keyboard.
///
/// Views can implement the protocol to get access to shared
/// typealiases and system keyboard functionality.
public protocol SystemKeyboardComponent: View {
    
    /// The view type to  button content view to use.
    associatedtype ButtonContent: View
    
    /// The button view
    associatedtype ButtonView: View
}

public extension SystemKeyboardComponent {
    
    /// A button content builder typalias.
    typealias ButtonContentBuilder = (ButtonContentParams) -> ButtonContent
    
    /// A button content builder params typalias.
    typealias ButtonContentParams = (
        item: KeyboardLayout.Item,
        view: StandardButtonContent
    )
    
    
    /// A button view builder typalias.
    typealias ButtonViewBuilder = (ButtonViewParams) -> ButtonView
    
    /// A button view builder params typalias.
    typealias ButtonViewParams = (
        item: KeyboardLayout.Item,
        view: StandardButtonView
    )
    
    
    /// An emoji keyboard builder params typalias.
    typealias EmojiKeyboardParams = (
        style: EmojiKeyboardStyle,
        view: StandardEmojiKeyboard
    )
    
    
    /// The standard button content view type.
    typealias StandardButtonContent = Keyboard.ButtonContent
    
    /// The standard button view type.
    typealias StandardButtonView = SystemKeyboardItem<ButtonContent>
    
    /// The standard emoji keyboard view type.
    typealias StandardEmojiKeyboard = Emoji.KeyboardWrapper
    
    /// The standard toolbar view type.
    typealias StandardToolbarView = Autocomplete.Toolbar<Autocomplete.ToolbarItem, Autocomplete.ToolbarSeparator>


    /// A toolbar builder params typalias.
    typealias ToolbarParams = (
        autocompleteAction: (Autocomplete.Suggestion) -> Void,
        style: Autocomplete.ToolbarStyle,
        view: StandardToolbarView)
    
    
    /// An autocomplete toolbar action typalias.
    typealias AutocompleteToolbarAction = (Autocomplete.Suggestion) -> Void
}

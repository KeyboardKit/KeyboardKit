//
//  KeyboardViewComponent.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-04-18.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This protocol can be implemented by view components that
/// can render parts of a ``KeyboardView``.
///
/// Views can implement the protocol to get access to shared
/// typealiases and keyboard view functionality.
public protocol KeyboardViewComponent: View {

    /// The button content view type to use.
    associatedtype ButtonContent: View
    
    /// The button view type to use.
    associatedtype ButtonView: View
}

public extension KeyboardViewComponent {

    /// This typealias defines a button content builder.
    typealias ButtonContentBuilder = (ButtonContentParams) -> ButtonContent
    
    /// This typealias defines button content builder params.
    typealias ButtonContentParams = (
        item: KeyboardLayout.Item,
        view: StandardButtonContent
    )

    /// This typealias defines a button view builder.
    typealias ButtonViewBuilder = (ButtonViewParams) -> ButtonView

    /// This typealias defines button view builder params.
    typealias ButtonViewParams = (
        item: KeyboardLayout.Item,
        view: StandardButtonView
    )
}

public extension KeyboardViewComponent {

    /// The standard button content view type.
    typealias StandardButtonContent = Keyboard.ButtonContent
    
    /// The standard button view type.
    typealias StandardButtonView = KeyboardViewItem<ButtonContent>
}

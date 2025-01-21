//
//  KeyboardTheme.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-18.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This struct defines a keyboard-specific theme, which can
/// be used to define a bunch of styles at once.
///
/// A theme can be copied, tweaked, styled, etc. This struct
/// implements the ``KeyboardThemeCopyable`` protocol to let
/// it share copy logic with its style variation.
///
/// KeyboardKit Pro unlocks a bunch of predefined themes and
/// style variations, as well as a theme-based style service.
///
/// See <doc:Themes-Article> for more information.
public struct KeyboardTheme: KeyboardThemeCopyable, Codable, Equatable, Identifiable {

    /// This enum defines various button types.
    public enum ButtonType: String, Codable {

        /// Input buttons are the light ones that enter text.
        case input

        /// System buttons are darker and trigger actions.
        case system

        /// Primary buttons are the prominent return buttons.
        case primary
    }

    /// The unique theme ID.
    public var id: UUID

    /// The name of the theme.
    public var name: String

    /// The name of a collection to which the theme belongs.
    public var collectionName: String

    /// The name of the author, if any.
    public var author: Author?

    /// The background style to apply, if any.
    public var backgroundStyle: Keyboard.Background?

    /// The foreground color to apply, if any.
    public var foregroundColor: Color?

    /// The button styles to apply to certain button types.
    public var buttonStyles: [ButtonType: Keyboard.ButtonStyle]

    /// The style to apply to autocomplete toolbars, if any.
    public var autocompleteToolbarStyle: Autocomplete.ToolbarStyle?

    /// The callout style to apply, if any.
    public var calloutStyle: KeyboardCallout.CalloutStyle?
}

public extension KeyboardTheme {

    /// This struct defines a theme author.
    struct Author: Codable, Equatable {

        /// Create a theme author value.
        public init(
            name: String,
            about: String? = nil,
            url: String? = nil
        ) {
            self.name = name
            self.about = about
            self.url = url
        }

        /// The name of the author.
        public var name: String

        /// Some information about the author, if any.
        public var about: String?

        /// The URL to the author website/socials, if any.
        public var url: String?
    }
}

/// This protocol is implemented by pro theme components, to
/// make it possible to create mutable copies.
public protocol KeyboardThemeCopyable: Identifiable where ID == UUID {

    /// The unique theme component ID.
    var id: ID { get set }

    /// The name of the theme component.
    var name: String { get set }
}

public extension KeyboardThemeCopyable {

    /// Create a copy of this theme component.
    ///
    /// If you don't provide an ID, the new value will get a
    /// random generated, unique ID.
    ///
    /// - Parameters:
    ///   - id: An optional, explicit ID.
    ///   - newName: An optional new name.
    func copy(
        newId id: UUID? = nil,
        newName: String? = nil
    ) -> Self {
        var copy = self
        copy.id = id ?? .init()
        copy.name = newName ?? copy.name
        return copy
    }
}

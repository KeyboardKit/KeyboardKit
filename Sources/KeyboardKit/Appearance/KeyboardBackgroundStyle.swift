//
//  KeyboardBackgroundStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-18.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This style defines the background of a keyboard.

 You can modify the ``standard`` style to change the default,
 global background style.
 */
public struct KeyboardBackgroundStyle {

    /**
     Create a keyboard background style.

     - Parameters:
        - type: The background type to use, by default `.clear`.
     */
    public init(
        _ type: BackgroundType = .clear
    ) {
        self.backgroundType = type
    }

    /**
     Create a keyboard background style.

     - Parameters:
       - type: The background type to use, by default `.clear`.
     */
    @available(*, deprecated, message: "You no longer have to specify the type parameter name")
    public init(type: BackgroundType) {
        self.backgroundType = type
    }

    /**
     The background type to use.
     */
    public var backgroundType: BackgroundType

    /**
     This enum defines supported keyboard background types.
     */
    public enum BackgroundType {

        /// A plain color background.
        case clear

        /// A plain color background.
        case color(Color)

        /// An image background.
        case image(Image)

        /// A linear gradient color background.
        case linearGradient(LinearGradient)

        /// A vertical gradient with top-to-bottom colors.
        case verticalGradient([Color])
    }
}

public extension KeyboardBackgroundStyle {

    /**
     This standard style mimics the native iOS style.

     This can be set to change the standard value everywhere.
     */
    static var standard = KeyboardBackgroundStyle()

    /**
     The background view to use for the style.
     */
    @ViewBuilder
    var backgroundView: some View {
        switch backgroundType {
        case .clear: Color.clear
        case .color(let color): color
        case .image(let image): image
        case .linearGradient(let gradient): gradient
        case .verticalGradient(let colors): LinearGradient(colors: colors, startPoint: .top, endPoint: .bottom)
        }
    }
}

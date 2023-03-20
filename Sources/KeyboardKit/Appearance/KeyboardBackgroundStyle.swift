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
 */
public struct KeyboardBackgroundStyle {

    /**
     Create a keyboard background style.

     - Parameters:
       - type: The background type to use, by default `.color(_:)` with a clear color.
     */
    public init(
        type: BackgroundType = .color(.clear)
    ) {
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
        case color(Color)

        /// An image background.
        case image(Image)

        /// A linear gradient color background.
        case linearGradient(LinearGradient)
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
        case .color(let color): color
        case .linearGradient(let gradient): gradient
        case .image(let image): image
        }
    }
}

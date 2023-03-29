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
public struct KeyboardBackgroundStyle: Codable, Equatable {

    /**
     Create a keyboard background style.

     - Parameters:
        - type: The background type to use, by default `.clear`.
     */
    public init(
        _ type: KeyboardBackgroundType = .clear
    ) {
        self.backgroundType = type
    }

    /**
     The background type to use.
     */
    public var backgroundType: KeyboardBackgroundType
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
        backgroundType.view
    }
}

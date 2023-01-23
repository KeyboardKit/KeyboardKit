//
//  KeyboardEnabledLabel.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-09.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This label can be used to show different views depending on
 a provided enabled state.

 You can use this label with any bool value, but it is meant
 to present whether or not a keyboard is enabled, active etc.
 using an observed ``KeyboardEnabledState`` value.
 */
public struct KeyboardEnabledLabel: View {

    /**
     Create an enabled label.

     - Parameters:
       - isEnabled: Whether or not the state is enabled.
       - enabledText: The text to show when the state is enabled.
       - disabledText: The text to show when the state is disabled.
       - style: The style to use, by default ``KeyboardEnabledLabel/Style/standard``.
     */
    public init(
        isEnabled: Bool,
        enabledText: String,
        disabledText: String,
        style: Style = .standard
    ) {
        self.isEnabled = isEnabled
        self.enabledText = enabledText
        self.disabledText = disabledText
        self.style = style
    }

    private let isEnabled: Bool
    private let enabledText: String
    private let disabledText: String
    private let style: Style

    public var body: some View {
        Label {
            Text(isEnabled ? enabledText : disabledText)
        } icon: {
            isEnabled ? style.enabledIcon : style.disabledIcon
        }.foregroundColor(isEnabled ? style.enabledColor : style.disabledColor)
    }
}

public extension KeyboardEnabledLabel {

    /**
     This style can be used with a ``KeyboardEnabledLabel``.
     */
    struct Style: Equatable {

        /**
         Create an enabled label style.

         - Parameters:
           - enabledIcon: The icon to use when the state is enabled, by default a `checkmark`.
           - enabledColor: The color to use when the state is enabled, by default `.green`.
           - disabledIcon: The icon to use when the state is disabled, by default a `warning triangle`.
           - disabledColor: The color to use when the state is disabled, by default `.orange`.
         */
        public init(
            enabledIcon: Image? = nil,
            enabledColor: Color = .green,
            disabledIcon: Image? = nil,
            disabledColor: Color = .orange
        ) {
            self.enabledIcon = enabledIcon ?? .symbol("checkmark")
            self.enabledColor = enabledColor
            self.disabledIcon = disabledIcon ?? .symbol("exclamationmark.triangle")
            self.disabledColor = disabledColor
        }

        /// The icon to use when the state is enabled/active.
        public var enabledIcon: Image

        /// The color to use when the state is enabled/active.
        public var enabledColor: Color

        /// The icon to use when the state is disabled/active.
        public var disabledIcon: Image

        /// The color to use when the state is disabled/active.
        public var disabledColor: Color
    }
}

public extension KeyboardEnabledLabel.Style {

    /**
     This is the standard ``KeyboardEnabledLabel`` style.

     You can modify this style to globally affect every view
     that is created with the standard style.
     */
    static var standard = KeyboardEnabledLabel.Style()
}


struct KeyboardEnabledLabel_Previews: PreviewProvider {

    static var previews: some View {
        List {
            KeyboardEnabledLabel(
                isEnabled: true,
                enabledText: "Enabled",
                disabledText: "Disabled")
            KeyboardEnabledLabel(
                isEnabled: false,
                enabledText: "Enabled",
                disabledText: "Disabled")
        }
    }
}

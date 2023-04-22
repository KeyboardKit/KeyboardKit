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
 a provided enabled/active state.

 You can use the label with any bool value, but the intended
 usaber is to present whether or not a keyboard extension is
 enabled, active etc.
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
        style: KeyboardEnabledLabel.Style = .standard
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
            text.foregroundColor(textColor).font(textFont)
        } icon: {
            icon.foregroundColor(iconColor).font(iconFont)
        }
    }
}

private extension KeyboardEnabledLabel {

    var icon: some View {
        value(style.enabledIcon, style.disabledIcon)
    }

    var iconColor: Color? {
        value(style.enabledIconStyle.color, style.disabledIconStyle.color)
    }

    var iconFont: Font? {
        value(style.enabledIconStyle.font, style.disabledIconStyle.font)
    }

    var text: Text {
        Text(value(enabledText, disabledText))
    }

    var textColor: Color? {
        value(style.enabledTextStyle.color, style.disabledTextStyle.color)
    }

    var textFont: Font? {
        value(style.enabledTextStyle.font, style.disabledTextStyle.font)
    }

    func value<T>(_ enabled: T, _ disabled: T) -> T {
        isEnabled ? enabled : disabled
    }
}

public extension KeyboardEnabledLabel {

    /**
     This style can be used with a ``KeyboardEnabledLabel``.
     */
    struct ComponentStyle: Equatable {

        public init(color: Color?, font: Font?) {
            self.color = color
            self.font = font
        }

        public var color: Color?
        public var font: Font?
    }

    /**
     This style can be used with a ``KeyboardEnabledLabel``.
     */
    struct Style: Equatable {

        /**
         Create an enabled label style.

         - Parameters:
           - enabledIcon: The icon to use when the state is enabled, by default a `checkmark`.
           - enabledIconStyle: The icon style to use when the state is enabled.
           - enabledTextStyle: The text style to use when the state is enabled.
           - disabledIcon: The icon to use when the state is disabled, by default a `exclamationmark.triangle`.
           - disabledIconStyle: The icon style to use when the state is disabled.
           - disabledTextStyle: The text style to use when the state is disabled.
         */
        public init(
            enabledIcon: Image? = nil,
            enabledIconStyle: ComponentStyle = .init(color: .green, font: nil),
            enabledTextStyle: ComponentStyle = .init(color: nil, font: nil),
            disabledIcon: Image? = nil,
            disabledIconStyle: ComponentStyle = .init(color: .orange, font: nil),
            disabledTextStyle: ComponentStyle = .init(color: nil, font: nil)
        ) {
            self.enabledIcon = enabledIcon ?? .symbol("checkmark")
            self.enabledIconStyle = enabledIconStyle
            self.enabledTextStyle = enabledTextStyle
            self.disabledIcon = disabledIcon ?? .symbol("exclamationmark.triangle")
            self.disabledIconStyle = disabledIconStyle
            self.disabledTextStyle = disabledTextStyle
        }

        /// The icon to use when the state is enabled/active.
        public var enabledIcon: Image

        /// The icon style to use when the state is enabled/active.
        public var enabledIconStyle: ComponentStyle

        /// The text style to use when the state is enabled/active.
        public var enabledTextStyle: ComponentStyle

        /// The icon to use when the state is disabled/inactive.
        public var disabledIcon: Image

        /// The icon style to use when the state is disabled/inactive.
        public var disabledIconStyle: ComponentStyle

        /// The text style to use when the state is disabled/inactive.
        public var disabledTextStyle: ComponentStyle
    }
}

public extension KeyboardEnabledLabel.Style {

    /**
     This is the standard ``KeyboardEnabledLabel`` style. It


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
                disabledText: "Disabled"
            )
            KeyboardEnabledLabel(
                isEnabled: false,
                enabledText: "Enabled",
                disabledText: "Disabled"
            )
        }
    }
}

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
 use is to easily present if a keyboard extension is enabled,
 active etc. It supports styling, but if you want a distinct
 look and feel, use a plain `Label`.
 */
public struct KeyboardEnabledLabel<EnabledIcon: View, DisabledIcon: View>: View {

    /**
     Create an enabled label.

     - Parameters:
       - isEnabled: Whether or not the state is enabled.
       - enabledText: The text to show when the state is enabled.
       - enabledIcon: The icon to show when the state is enabled, by default `checkmark`.
       - disabledText: The text to show when the state is disabled.
       - disabledIcon: The icon to show when the state is disabled, by default `exclamationmark.triangle`.
       - style: The style to use, by default ``KeyboardEnabledLabelStyle/standard``.
     */
    public init(
        isEnabled: Bool,
        enabledIcon: EnabledIcon,
        enabledText: String,
        disabledIcon: DisabledIcon,
        disabledText: String,
        style: KeyboardEnabledLabelStyle = .standard
    ) {
        self.isEnabled = isEnabled
        self.enabledText = enabledText
        self.enabledIcon = enabledIcon
        self.disabledText = disabledText
        self.disabledIcon = disabledIcon
        self.style = style
    }

    private let isEnabled: Bool
    private let enabledText: String
    private let enabledIcon: EnabledIcon
    private let disabledText: String
    private let disabledIcon: DisabledIcon
    private let style: KeyboardEnabledLabelStyle

    public var body: some View {
        Label {
            text.foregroundColor(textColor).font(textFont)
        } icon: {
            icon.foregroundColor(iconColor).font(iconFont)
        }
    }
}

public extension KeyboardEnabledLabel where EnabledIcon == Image, DisabledIcon == Image {

    /**
     Create an enabled label.

     - Parameters:
       - isEnabled: Whether or not the state is enabled.
       - enabledText: The text to show when the state is enabled.
       - enabledIcon: The icon to show when the state is enabled, by default `checkmark`.
       - disabledText: The text to show when the state is disabled.
       - disabledIcon: The icon to show when the state is disabled, by default `exclamationmark.triangle`.
       - style: The style to use, by default ``KeyboardEnabledLabel/Style/standard``.
     */
    init(
        isEnabled: Bool,
        enabledIcon: Image = Image(systemName: "checkmark"),
        enabledText: String,
        disabledIcon: Image = Image(systemName: "exclamationmark.triangle"),
        disabledText: String,
        style: KeyboardEnabledLabelStyle = .standard
    ) {
        self.isEnabled = isEnabled
        self.enabledText = enabledText
        self.enabledIcon = enabledIcon
        self.disabledText = disabledText
        self.disabledIcon = disabledIcon
        self.style = style
    }
}

private extension KeyboardEnabledLabel {

    @ViewBuilder
    var icon: some View {
        if isEnabled {
            enabledIcon
        } else {
            disabledIcon
        }
    }

    var iconColor: Color? {
        value(style.enabledIcon.color, style.disabledIcon.color)
    }

    var iconFont: Font? {
        value(style.enabledIcon.font, style.disabledIcon.font)
    }

    var text: Text {
        Text(value(enabledText, disabledText))
    }

    var textColor: Color? {
        value(style.enabledText.color, style.disabledText.color)
    }

    var textFont: Font? {
        value(style.enabledText.font, style.disabledText.font)
    }

    func value<T>(_ enabled: T, _ disabled: T) -> T {
        isEnabled ? enabled : disabled
    }
}

/**
 This style can be used with a ``KeyboardEnabledLabel``.
 */
public struct KeyboardEnabledLabelStyle: Equatable {

    /**
     This style can be used with a ``KeyboardEnabledLabel``.
     */
    public struct ComponentStyle: Equatable {

        public init(color: Color?, font: Font?) {
            self.color = color
            self.font = font
        }

        public var color: Color?
        public var font: Font?
    }

    /**
     Create an enabled label style.

     - Parameters:
       - enabledIcon: The icon style to use when the state is enabled.
       - enabledText: The text style to use when the state is enabled.
       - disabledIcon: The icon style to use when the state is disabled.
       - disabledText: The text style to use when the state is disabled.
     */
    public init(
        enabledIcon: ComponentStyle = .init(color: .green, font: nil),
        enabledText: ComponentStyle = .init(color: nil, font: nil),
        disabledIcon: ComponentStyle = .init(color: .orange, font: nil),
        disabledText: ComponentStyle = .init(color: nil, font: nil)
    ) {
        self.enabledIcon = enabledIcon
        self.enabledText = enabledText
        self.disabledIcon = disabledIcon
        self.disabledText = disabledText
    }

    /// The icon style to use when the state is enabled/active.
    public var enabledIcon: ComponentStyle

    /// The text style to use when the state is enabled/active.
    public var enabledText: ComponentStyle

    /// The icon style to use when the state is disabled/inactive.
    public var disabledIcon: ComponentStyle

    /// The text style to use when the state is disabled/inactive.
    public var disabledText: ComponentStyle
}

public extension KeyboardEnabledLabelStyle {

    /**
     This is the standard ``KeyboardEnabledLabel`` style. It


     You can modify this style to globally affect every view
     that is created with the standard style.
     */
    static var standard = KeyboardEnabledLabelStyle()
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

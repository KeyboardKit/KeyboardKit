//
//  KeyboardStateLabel.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-09.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This label can be used to show different views depending on
 a provided state.

 While you can use this label with any boolean, the intended
 use is to show if the keyboard extension is enabled, if the
 app has full access etc.
 */
public struct KeyboardStateLabel<EnabledIcon: View, DisabledIcon: View>: View {

    /**
     Create an enabled label.

     - Parameters:
       - isEnabled: Whether or not the state is enabled.
       - enabledText: The text to show when the state is enabled.
       - enabledIcon: The icon to show when the state is enabled, by default `checkmark`.
       - disabledText: The text to show when the state is disabled.
       - disabledIcon: The icon to show when the state is disabled, by default `exclamationmark.triangle`.
       - style: The style to use, by default ``KeyboardStateLabelStyle/standard``.
     */
    public init(
        isEnabled: Bool,
        enabledIcon: EnabledIcon,
        enabledText: String,
        disabledIcon: DisabledIcon,
        disabledText: String,
        style: KeyboardStateLabelStyle = .standard
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
    private let style: KeyboardStateLabelStyle

    public var body: some View {
        Label {
            text.foregroundColor(textColor).font(textFont)
        } icon: {
            icon.foregroundColor(iconColor).font(iconFont)
        }
    }
}

public extension KeyboardStateLabel where EnabledIcon == Image, DisabledIcon == Image {

    /**
     Create an enabled label.

     - Parameters:
       - isEnabled: Whether or not the state is enabled.
       - enabledText: The text to show when the state is enabled.
       - enabledIcon: The icon to show when the state is enabled, by default `checkmark`.
       - disabledText: The text to show when the state is disabled.
       - disabledIcon: The icon to show when the state is disabled, by default `exclamationmark.triangle`.
       - style: The style to use, by default ``KeyboardStateLabelStyle/standard``.
     */
    init(
        isEnabled: Bool,
        enabledIcon: Image = .init(systemName: "checkmark"),
        enabledText: String,
        disabledIcon: Image = .init(systemName: "exclamationmark.triangle"),
        disabledText: String,
        style: KeyboardStateLabelStyle = .standard
    ) {
        self.isEnabled = isEnabled
        self.enabledText = enabledText
        self.enabledIcon = enabledIcon
        self.disabledText = disabledText
        self.disabledIcon = disabledIcon
        self.style = style
    }
}

private extension KeyboardStateLabel {

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
 This style can be used with ``KeyboardStateLabel`` views.
 */
public struct KeyboardStateLabelStyle: Equatable {

    /**
     This style can be used with a ``KeyboardStateLabel``.
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

public extension KeyboardStateLabelStyle {

    /**
     This is the standard ``KeyboardStateLabel`` style. It


     You can modify this style to globally affect every view
     that is created with the standard style.
     */
    static var standard = KeyboardStateLabelStyle()
}


struct KeyboardStateLabel_Previews: PreviewProvider {

    static var previews: some View {
        List {
            KeyboardStateLabel(
                isEnabled: true,
                enabledText: "Enabled",
                disabledText: "Disabled"
            )
            KeyboardStateLabel(
                isEnabled: false,
                enabledText: "Enabled",
                disabledText: "Disabled"
            )
        }
    }
}

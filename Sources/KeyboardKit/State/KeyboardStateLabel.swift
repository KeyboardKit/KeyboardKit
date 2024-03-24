//
//  KeyboardStateLabel.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-09.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This label can be used to show different views depending
/// on a certain provided state.
///
/// While you can use this label with any bool, the intended
/// use is to show if a keyboard extension is enabled, if is
/// has full access etc.
public struct KeyboardStateLabel<EnabledIcon: View, DisabledIcon: View>: View {
    
    /// Create an enabled label.
    ///
    /// - Parameters:
    ///   - isEnabled: Whether or not the state is enabled.
    ///   - enabledText: The text to show when the state is enabled.
    ///   - enabledIcon: The icon to show when the state is enabled, by default `checkmark`.
    ///   - disabledText: The text to show when the state is disabled.
    ///   - disabledIcon: The icon to show when the state is disabled, by default `exclamationmark.triangle`.
    public init(
        isEnabled: Bool,
        enabledIcon: EnabledIcon,
        enabledText: String,
        disabledIcon: DisabledIcon,
        disabledText: String
    ) {
        self.isEnabled = isEnabled
        self.enabledText = enabledText
        self.enabledIcon = enabledIcon
        self.disabledText = disabledText
        self.disabledIcon = disabledIcon
        self.initStyle = nil
    }

    private let isEnabled: Bool
    private let enabledText: String
    private let enabledIcon: EnabledIcon
    private let disabledText: String
    private let disabledIcon: DisabledIcon
    
    @Environment(\.keyboardStateLabelStyle)
    private var envStyle

    public var body: some View {
        Label {
            text.foregroundColor(textColor).font(textFont)
        } icon: {
            icon.foregroundColor(iconColor).font(iconFont)
        }
    }
    
    // MARK: - Deprecated
    
    @available(*, deprecated, message: "Use .keyboardStateLabelStyle to apply the style instead.")
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
        self.initStyle = style
    }
    
    private typealias Style = KeyboardStateLabelStyle
    private let initStyle: Style?
    private var style: Style { initStyle ?? envStyle }
}

public extension KeyboardStateLabel where EnabledIcon == Image, DisabledIcon == Image {
    
    /// Create an enabled label.
    ///
    /// - Parameters:
    ///   - isEnabled: Whether or not the state is enabled.
    ///   - enabledText: The text to show when the state is enabled.
    ///   - enabledIcon: The icon to show when the state is enabled, by default `checkmark`.
    ///   - disabledText: The text to show when the state is disabled.
    ///   - disabledIcon: The icon to show when the state is disabled, by default `exclamationmark.triangle`.
    init(
        isEnabled: Bool,
        enabledIcon: Image = .init(systemName: "checkmark"),
        enabledText: String,
        disabledIcon: Image = .init(systemName: "exclamationmark.triangle"),
        disabledText: String
    ) {
        self.isEnabled = isEnabled
        self.enabledText = enabledText
        self.enabledIcon = enabledIcon
        self.disabledText = disabledText
        self.disabledIcon = disabledIcon
        self.initStyle = nil
    }
    
    @available(*, deprecated, message: "Style this view with .keyboardStateLabelStyle instead.")
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
        self.initStyle = style
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

#Preview {

    List {
        Section {
            ForEach([true, false], id: \.self) {
                KeyboardStateLabel(
                    isEnabled: $0,
                    enabledText: "Enabled",
                    disabledText: "Disabled"
                )
            }
        }
        Section {
            ForEach([true, false], id: \.self) {
                KeyboardStateLabel(
                    isEnabled: $0,
                    enabledIcon: Color.green,
                    enabledText: "Yes",
                    disabledIcon: Color.red,
                    disabledText: "No"
                )
            }
        }
    }
}

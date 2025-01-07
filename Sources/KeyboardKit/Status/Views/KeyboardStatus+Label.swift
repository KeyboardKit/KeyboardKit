//
//  KeyboardStatus+Label.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-09.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardStatus {
    
    /// This label can be used to show the currently enabled
    /// state for a keyboard.
    ///
    /// While you can use it with any bool, the intended use
    /// is to show if a keyboard extension is enabled, if is
    /// has full access etc.
    ///
    /// You can style this component with the style modifier
    /// ``keyboardStatusLabelStyle(_:)``.
    struct Label: View {
        
        /// Create an enabled label.
        ///
        /// - Parameters:
        ///   - isEnabled: Whether or not the state is enabled.
        ///   - enabledText: The text to show when the state is enabled.
        ///   - disabledText: The text to show when the state is disabled.
        public init(
            isEnabled: Bool,
            enabledText: String,
            disabledText: String
        ) {
            self.isEnabled = isEnabled
            self.enabledText = enabledText
            self.disabledText = disabledText
        }
        
        private let isEnabled: Bool
        private let enabledText: String
        private let disabledText: String
        
        @Environment(\.keyboardStatusLabelStyle)
        private var style

        public var body: some View {
            SwiftUI.Label {
                text.foregroundColor(textColor).font(textFont)
            } icon: {
                icon.foregroundColor(iconColor).font(iconFont)
            }
        }
    }
}

private extension KeyboardStatus.Label {

    @ViewBuilder
    var icon: some View {
        if isEnabled {
            style.enabledIcon
        } else {
            style.disabledIcon
        }
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

#Preview {

    List {
        Section {
            ForEach([true, false], id: \.self) {
                KeyboardStatus.Label(
                    isEnabled: $0,
                    enabledText: "Enabled",
                    disabledText: "Disabled"
                )
            }
        }
        Section {
            ForEach([true, false], id: \.self) {
                KeyboardStatus.Label(
                    isEnabled: $0,
                    enabledText: "Enabled",
                    disabledText: "Disabled"
                )
            }
        }
        .keyboardStatusLabelStyle(
            .init(
                enabledIcon: Circle().fill(.green),
                disabledIcon: Circle().fill(.orange)
            )
        )
    }
}

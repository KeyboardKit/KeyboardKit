//
//  KeyboardStatus+LabelStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-09.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardStatus {
    
    /// This style can be used to modify the visual style of
    /// the ``KeyboardStatus/Label`` component.
    ///
    /// You can apply this view style with the view modifier
    /// ``SwiftUICore/View/keyboardStatusLabelStyle(_:)``.
    ///
    /// You can use the ``standard`` style or your own style.
    struct LabelStyle {
        
        /// Create a custom keyboard state label style.
        ///
        /// - Parameters:
        ///   - enabledIcon: The enabled icon view.
        ///   - enabledIconStyle: The enabled icon style, by default `.green`.
        ///   - enabledTextStyle: The enabled text style, if any.
        ///   - disabledIcon: The enabled icon view.
        ///   - disabledIconStyle: The disabled icon style, by default `.orange`.
        ///   - disabledTextStyle: The disabled text style, if any.
        public init<EnabledIcon: View, DisabledIcon: View>(
            enabledIcon: EnabledIcon,
            enabledIconStyle: ComponentStyle = .init(color: .green, font: nil),
            enabledTextStyle: ComponentStyle = .init(color: nil, font: nil),
            disabledIcon: DisabledIcon,
            disabledIconStyle: ComponentStyle = .init(color: .orange, font: nil),
            disabledTextStyle: ComponentStyle = .init(color: nil, font: nil)
        ) {
            self.enabledIcon = AnyView(enabledIcon)
            self.enabledIconStyle = enabledIconStyle
            self.enabledTextStyle = enabledTextStyle
            self.disabledIcon = AnyView(disabledIcon)
            self.disabledIconStyle = disabledIconStyle
            self.disabledTextStyle = disabledTextStyle
        }
        
        /// Create a custom keyboard state label style.
        ///
        /// - Parameters:
        ///   - enabledIconStyle: The enabled icon style, by default `.green`.
        ///   - enabledTextStyle: The enabled text style, if any.
        ///   - disabledIconStyle: The disabled icon style, by default `.orange`.
        ///   - disabledTextStyle: The disabled text style, if any.
        public init(
            enabledIconStyle: ComponentStyle = .init(color: .green, font: nil),
            enabledTextStyle: ComponentStyle = .init(color: nil, font: nil),
            disabledIconStyle: ComponentStyle = .init(color: .orange, font: nil),
            disabledTextStyle: ComponentStyle = .init(color: nil, font: nil)
        ) {
            self.enabledIcon = AnyView(
                Image(systemName: "checkmark.circle.fill")
            )
            self.enabledIconStyle = enabledIconStyle
            self.enabledTextStyle = enabledTextStyle
            self.disabledIcon = AnyView(
                Image(systemName: "exclamationmark.triangle.fill")
            )
            self.disabledIconStyle = disabledIconStyle
            self.disabledTextStyle = disabledTextStyle
        }
        
        /// This style defines the style of a label component.
        public struct ComponentStyle: Equatable {
            
            public init(
                color: Color?,
                font: Font?
            ) {
                self.color = color
                self.font = font
            }
            
            public var color: Color?
            public var font: Font?
        }
        
        /// The enabled icon view.
        public var enabledIcon: AnyView
        
        /// The enabled icon style.
        public var enabledIconStyle: ComponentStyle
        
        /// The enabled text style.
        public var enabledTextStyle: ComponentStyle
        
        /// The disabled icon view.
        public var disabledIcon: AnyView
        
        /// The disabled icon style.
        public var disabledIconStyle: ComponentStyle
        
        /// The disabled text style.
        public var disabledTextStyle: ComponentStyle
    }
}

public extension KeyboardStatus.LabelStyle {

    /// The standard status label style.
    static var standard: Self { .init() }
}

public extension View {

    /// Apply a ``KeyboardStatus/LabelStyle``.
    func keyboardStatusLabelStyle(
        _ style: KeyboardStatus.LabelStyle
    ) -> some View {
        self.environment(\.keyboardStatusLabelStyle, style)
    }
}

private extension KeyboardStatus.LabelStyle {

    struct Key: EnvironmentKey {

        static var defaultValue: KeyboardStatus.LabelStyle {
            .standard
        }
    }
}

public extension EnvironmentValues {

    var keyboardStatusLabelStyle: KeyboardStatus.LabelStyle {
        get { self [KeyboardStatus.LabelStyle.Key.self] }
        set { self [KeyboardStatus.LabelStyle.Key.self] = newValue }
    }
}

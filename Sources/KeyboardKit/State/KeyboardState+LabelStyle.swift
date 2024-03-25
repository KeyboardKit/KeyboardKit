//
//  KeyboardState+LabelStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-09.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardState {
    
    /// This style can be used to modify the visual style of
    /// the ``KeyboardState/Label`` component.
    ///
    /// You can apply this view style with the view modifier
    /// ``SwiftUI/View/keyboardStateLabelStyle(_:)``.
    ///
    /// You can use the ``standard`` style or your own style.
    struct LabelStyle: Equatable {
        
        /// Create a custom keyboard state label style.
        ///
        /// - Parameters:
        ///   - enabledIcon: The enabled icon style, by default `.green`.
        ///   - enabledText: The enabled text style, if any.
        ///   - disabledIcon: The disabled icon style, by default `.orange`.
        ///   - disabledText: The disabled text style, if any.
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
        
        /// The enabled icon style.
        public var enabledIcon: ComponentStyle
        
        /// The enabled text style.
        public var enabledText: ComponentStyle
        
        /// The disabled icon style.
        public var disabledIcon: ComponentStyle
        
        /// The disabled text style.
        public var disabledText: ComponentStyle
    }
}

public extension KeyboardState.LabelStyle {

    /// The standard state label style.
    ///
    /// You can set this style to change the global default.
    static var standard = Self()
}

public extension View {

    /// Apply a ``KeyboardState/LabelStyle``.
    func keyboardStateLabelStyle(
        _ style: KeyboardState.LabelStyle
    ) -> some View {
        self.environment(\.keyboardStateLabelStyle, style)
    }
}

private extension KeyboardState.LabelStyle {

    struct Key: EnvironmentKey {

        static var defaultValue: KeyboardState.LabelStyle = .standard
    }
}

public extension EnvironmentValues {

    var keyboardStateLabelStyle: KeyboardState.LabelStyle {
        get { self [KeyboardState.LabelStyle.Key.self] }
        set { self [KeyboardState.LabelStyle.Key.self] = newValue }
    }
}

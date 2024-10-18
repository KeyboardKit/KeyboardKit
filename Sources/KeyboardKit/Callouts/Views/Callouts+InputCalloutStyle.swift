//
//  Callouts+InputCalloutStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-07.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Callouts {
    
    /// This style can be used to modify the visual style of
    /// the ``Callouts/InputCallout`` component.
    ///
    /// You can apply this view style with the view modifier
    /// ``SwiftUICore/View/inputCalloutStyle(_:)``.
    ///
    /// You can use the ``standard`` style or your own style.
    struct InputCalloutStyle: Codable, Equatable {
        
        /// Create a custom input callout style.
        ///
        /// - Parameters:
        ///   - callout: The callout style to use, by default `.standard`.
        ///   - calloutPadding: The padding to apply to the callout content, by default `2`.
        ///   - calloutSize: The minimum size of the callout bubble, by default `.largeTitle .light`.
        ///   - font: The font to use in the callout.
        public init(
            callout: Callouts.CalloutStyle = .standard,
            calloutPadding: CGFloat = 2,
            calloutSize: CGSize = CGSize(width: 0, height: 55),
            font: KeyboardFont = .init(.largeTitle, .light)
        ) {
            self.callout = callout
            self.calloutPadding = calloutPadding
            self.calloutSize = calloutSize
            self.font = font
        }
        
        /// The style to use for the callout bubble.
        public var callout: Callouts.CalloutStyle
        
        /// The padding to apply to the callout content.
        public var calloutPadding: CGFloat
        
        /// The minimum callout size above the button area.
        public var calloutSize: CGSize
        
        /// The font to use in the callout.
        public var font: KeyboardFont
    }
}

public extension Callouts.InputCalloutStyle {
    
    /// The standard input callout style.
    static var standard: Self { .init() }
}

public extension View {

    /// Apply a ``Callouts/InputCalloutStyle``.
    func inputCalloutStyle(
        _ style: Callouts.InputCalloutStyle
    ) -> some View {
        self.environment(\.inputCalloutStyle, style)
    }
}

private extension Callouts.InputCalloutStyle {

    struct Key: EnvironmentKey {

        static var defaultValue: Callouts.InputCalloutStyle {
            .standard
        }
    }
}

public extension EnvironmentValues {

    var inputCalloutStyle: Callouts.InputCalloutStyle {
        get { self [Callouts.InputCalloutStyle.Key.self] }
        set { self [Callouts.InputCalloutStyle.Key.self] = newValue }
    }
}

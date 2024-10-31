//
//  Callouts+ActionCalloutStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-07.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Callouts {
    
    /// This style can be used to modify the visual style of
    /// the ``Callouts/ActionCallout`` component.
    ///
    /// You can apply this view style with the view modifier
    /// ``SwiftUICore/View/actionCalloutStyle(_:)``.
    ///
    /// You can use the ``standard`` style or your own style.
    struct ActionCalloutStyle: Codable, Equatable {
        
        /// Create a custom action callout style.
        ///
        /// - Parameters:
        ///   - callout: The callout style to use, by default `.standard`.
        ///   - font: The font to use in the callout, by default `.standardFont`.
        ///   - maxButtonSize: The max button size, by default a `50` point square.
        ///   - selectedBackgroundColor: The selected item background, by default `.blue`.
        ///   - selectedForegroundColor: The selected item foreground, by default `.white`.
        ///   - verticalOffset: The vertical offset of the action callout, by default `20` points on iPad devices and `0` otherwise.
        ///   - verticalTextPadding: The vertical padding to apply to text in the callout, by default `6`.
        public init(
            callout: Callouts.CalloutStyle = .standard,
            font: KeyboardFont = .init(.title3),
            maxButtonSize: CGSize = CGSize(width: 50, height: 50),
            selectedBackgroundColor: Color? = nil,
            selectedForegroundColor: Color? = nil,
            verticalOffset: CGFloat? = nil,
            verticalTextPadding: CGFloat = 6
        ) {
            self.callout = callout
            self.font = font
            self.maxButtonSize = maxButtonSize
            self.selectedBackgroundColor = selectedBackgroundColor ?? .blue
            self.selectedForegroundColor = selectedForegroundColor ?? .white
            self.verticalOffset = verticalOffset
            self.verticalTextPadding = verticalTextPadding
        }
        
        /// The style to use for the callout bubble.
        public var callout: Callouts.CalloutStyle
        
        /// The font to use in the callout.
        public var font: KeyboardFont
        
        /// The max size of the callout buttons.
        public var maxButtonSize: CGSize
        
        /// The background color of the selected item.
        public var selectedBackgroundColor: Color
        
        /// The foreground color of the selected item.
        public var selectedForegroundColor: Color
        
        /// The vertical offset to apply to the callout.
        public var verticalOffset: CGFloat?

        /// The vertical padding of the callout text.
        public var verticalTextPadding: CGFloat
    }
}

public extension Callouts.ActionCalloutStyle {
    
    /// The standard action callout style.
    static var standard: Self { .init() }

    /// The standard vertical offset for a certain device.
    func standardVerticalOffset(
        for device: DeviceType
    ) -> CGFloat {
        device == .pad ? 20 : 0
    }
}

public extension View {

    /// Apply a ``Callouts/ActionCalloutStyle``.
    func actionCalloutStyle(
        _ style: Callouts.ActionCalloutStyle
    ) -> some View {
        self.environment(\.actionCalloutStyle, style)
    }
}

public extension EnvironmentValues {

    /// Apply a ``Callouts/ActionCalloutStyle``.
    @Entry var actionCalloutStyle = Callouts
        .ActionCalloutStyle.standard
}

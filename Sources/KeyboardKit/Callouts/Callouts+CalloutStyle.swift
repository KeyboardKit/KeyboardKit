//
//  Callouts+CalloutStyles.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-07.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Callouts {
    
    /// This style can be used to modify the visual style of
    /// the ``Callouts`` components callout shape.
    ///
    /// You can apply this view style with the view modifier
    /// ``SwiftUICore/View/calloutStyle(_:)``.
    ///
    /// You can use the ``standard`` style or your own style.
    struct CalloutStyle: Codable, Equatable {
        
        /// Create a custom callout style.
        ///
        /// When creating custom styles, note that the style
        /// has components that are meant to fit the overall
        /// style. For instance, the corner and shadow radii
        /// should probably be the same as the corner radius
        /// of presenting button.
        ///
        /// Only customize the parameters you need, then use
        /// the default values for all other parameters.
        ///
        /// - Parameters:
        ///   - actionItemFont: The action item font, by default `.title3`.
        ///   - actionItemMaxSize: The max action item size, by default `50x50` points.
        ///   - actionItemPadding: The intrinsic action item padding, by default `0x6` points.
        ///   - backgroundColor: The callout background color, by default `.keyboardButtonBackground`.
        ///   - borderColor: The callout border color, by default transparent `.black`.
        ///   - buttonOverlayCornerRadius: A custom button overlay corner radius, if any.
        ///   - buttonOverlayInset: The button overlay inset, by default `.zero`.
        ///   - cornerRadius: The callout corner radius, by default `10`.
        ///   - curveSize: The callout to button curve size, by default `8x15` points.
        ///   - foregroundColor: The callout foreground color, by default `.primary`.
        ///   - inputItemFont: The input item font, by default `.largeTitle .light`.
        ///   - inputItemMinSize: The minimum input item size, by default `55` height.
        ///   - offset: A custom callout offset, if any.
        ///   - padding: The callout content padding, by default `2` points.
        ///   - selectedBackgroundColor: The selected item background, by default `.blue`.
        ///   - selectedForegroundColor: The selected item foreground, by default `.white`.
        ///   - shadowColor: The callout shadow color, by default 0.1 `.black`.
        ///   - shadowRadius: The callout shadow radius, by default `5`.
        public init(
            actionItemFont: KeyboardFont = .title3,
            actionItemMaxSize: CGSize = .init(width: 50, height: 50),
            actionItemPadding: CGSize = .init(width: 0, height: 6),
            backgroundColor: Color = .keyboardButtonBackground,
            borderColor: Color = .black.opacity(0.5),
            buttonOverlayCornerRadius: CGFloat? = nil,
            buttonOverlayInset: CGSize = .zero,
            cornerRadius: CGFloat = 10,
            curveSize: CGSize = .init(width: 8, height: 15),
            foregroundColor: Color = .primary,
            inputItemFont: KeyboardFont = .init(.largeTitle, .light),
            inputItemMinSize: CGSize = .init(width: 0, height: 55),
            offset: CGPoint? = nil,
            selectedBackgroundColor: Color = .blue,
            selectedForegroundColor: Color = .white,
            shadowColor: Color = .black.opacity(0.1),
            shadowRadius: CGFloat = 5
        ) {
            self.actionItemFont = actionItemFont
            self.actionItemMaxSize = actionItemMaxSize
            self.actionItemPadding = actionItemPadding
            self.backgroundColor = backgroundColor
            self.borderColor = borderColor
            self.buttonOverlayCornerRadius = buttonOverlayCornerRadius
            self.buttonOverlayInset = buttonOverlayInset
            self.cornerRadius = cornerRadius
            self.curveSize = curveSize
            self.foregroundColor = foregroundColor
            self.inputItemFont = inputItemFont
            self.inputItemMinSize = inputItemMinSize
            self.offset = offset
            self.selectedBackgroundColor = selectedBackgroundColor
            self.selectedForegroundColor = selectedForegroundColor
            self.shadowColor = shadowColor
            self.shadowRadius = shadowRadius
        }

        /// The action item font.
        public var actionItemFont: KeyboardFont

        /// The max action item size.
        public var actionItemMaxSize: CGSize

        /// The intrinsic action item padding.
        public var actionItemPadding: CGSize

        /// The callout background color.
        public var backgroundColor: Color
        
        /// The callout border color.
        public var borderColor: Color
        
        /// The button overlay corner radius.
        public var buttonOverlayCornerRadius: CGFloat?

        /// The button overlay inset.
        public var buttonOverlayInset: CGSize

        /// The callout corner radius.
        public var cornerRadius: CGFloat
        
        /// The callout to button overlay curve size.
        public var curveSize: CGSize

        /// The callout foreground color.
        public var foregroundColor: Color

        /// The action item font.
        public var inputItemFont: KeyboardFont

        /// The minimum input item size.
        public var inputItemMinSize: CGSize

        /// A custom callout offset, if any.
        public var offset: CGPoint?

        /// The selected item background.
        public var selectedBackgroundColor: Color

        /// The selected item foreground.
        public var selectedForegroundColor: Color

        /// The callout shadow color.
        public var shadowColor: Color
        
        /// The callout shadow radius.
        public var shadowRadius: CGFloat
    }
}

public extension Callouts.CalloutStyle {

    /// The corner radius to use for the provided context.
    func buttonCornerRadius(
        for context: KeyboardContext
    ) -> Double {
        if let radius = buttonOverlayCornerRadius { return radius }
        let config = KeyboardLayout.Configuration.standard(for: context)
        return config.buttonCornerRadius
    }

    /// The standard vertical offset for the provided device.
    func standardVerticalOffset(
        for device: DeviceType
    ) -> CGFloat {
        device == .pad ? 20 : 0
    }
}

public extension Callouts.CalloutStyle {
    
    /// A standard callout style.
    static var standard: Self { .init() }
}

extension Callouts.CalloutStyle {

    static var preview1: Self {
        .init(
            backgroundColor: .red,
            borderColor: .white,
            buttonOverlayCornerRadius: 10,
            foregroundColor: .black,
            shadowColor: .green,
            shadowRadius: 3
        )
    }
    
    static var preview2: Self {
        .init(
            backgroundColor: .green,
            borderColor: .white,
            buttonOverlayCornerRadius: 20,
            foregroundColor: .red,
            shadowColor: .black,
            shadowRadius: 10
        )
    }
}

public extension View {

    /// Apply a ``Callouts/CalloutStyle``.
    func calloutStyle(
        _ style: Callouts.CalloutStyle
    ) -> some View {
        self.environment(\.calloutStyle, style)
    }
}

public extension EnvironmentValues {

    /// Apply a ``Callouts/CalloutStyle``.
    @Entry var calloutStyle = Callouts
        .CalloutStyle.standard
}

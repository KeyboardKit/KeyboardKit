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
    /// ``SwiftUI/View/calloutStyle(_:)``.
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
        ///   - backgroundColor: The background color of the entire callout, by default `.keyboardButtonBackground`.
        ///   - borderColor: The border color of the entire callout, by default transparent `.black`.
        ///   - buttonCornerRadius: The corner radius of the callout edges, by default `4`.
        ///   - buttonInset: The inset to apply to the button overlay, by default transparent `.zero`.
        ///   - cornerRadius: The corner radius of the callout edges, by default transparent `10`.
        ///   - curveSize: The size of the curve that links the button overlay and callout, by default transparent `8x15`.
        ///   - shadowColor: The shadow of the entire callout, by default transparent transparent `.black`.
        ///   - shadowRadius: The shadow radius of the entire callout, by default transparent `5`.
        ///   - textColor: The text color to use in the callout, by default `.primary`.
        public init(
            backgroundColor: Color = .keyboardButtonBackground,
            borderColor: Color = Color.black.opacity(0.5),
            buttonCornerRadius: CGFloat = 5,
            buttonInset: CGSize = CGSize.zero,
            cornerRadius: CGFloat = 10,
            curveSize: CGSize = CGSize(width: 8, height: 15),
            shadowColor: Color = Color.black.opacity(0.1),
            shadowRadius: CGFloat = 5,
            textColor: Color = .primary
        ) {
            self.backgroundColor = backgroundColor
            self.borderColor = borderColor
            self.buttonCornerRadius = buttonCornerRadius
            self.buttonInset = buttonInset
            self.cornerRadius = cornerRadius
            self.curveSize = curveSize
            self.shadowColor = shadowColor
            self.shadowRadius = shadowRadius
            self.textColor = textColor
        }
        
        /// The background color of the entire callout.
        public var backgroundColor: Color
        
        /// The border color of the entire callout.
        public var borderColor: Color
        
        /// The corner radius of the button overlay.
        public var buttonCornerRadius: CGFloat
        
        /// The insets of the parts that overlaps the button.
        public var buttonInset: CGSize
        
        /// The corner radius of the callout edges.
        public var cornerRadius: CGFloat
        
        /// The size of the callout curve.
        public var curveSize: CGSize
        
        /// The shadow of the entire callout.
        public var shadowColor: Color
        
        /// The shadow radius of the entire callout.
        public var shadowRadius: CGFloat
        
        /// The text color to use in the callout.
        public var textColor: Color
    }
}

public extension Callouts.CalloutStyle {
    
    /// The standard callout style.
    ///
    /// You can set this style to change the global default.
    static var standard = Self()
}

extension Callouts.CalloutStyle {
    
    static var preview1 = Self(
        backgroundColor: .red,
        borderColor: .white,
        buttonCornerRadius: 10,
        shadowColor: .green,
        shadowRadius: 3,
        textColor: .black
    )
    
    static var preview2 = Self(
        backgroundColor: .green,
        borderColor: .white,
        buttonCornerRadius: 20,
        shadowColor: .black,
        shadowRadius: 10,
        textColor: .red
    )
}

public extension View {

    /// Apply a ``Callouts/CalloutStyle``.
    func calloutStyle(
        _ style: Callouts.CalloutStyle
    ) -> some View {
        self.environment(\.calloutStyle, style)
    }
}

private extension Callouts.CalloutStyle {

    struct Key: EnvironmentKey {

        static var defaultValue: Callouts.CalloutStyle = .standard
    }
}

public extension EnvironmentValues {

    var calloutStyle: Callouts.CalloutStyle {
        get { self [Callouts.CalloutStyle.Key.self] }
        set { self [Callouts.CalloutStyle.Key.self] = newValue }
    }
}

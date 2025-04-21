//
//  KeyboardCallout+ActionCalloutButtonArea.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-04-10.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardCallout.ActionCallout {

    /// This view is used to cover the part of a button that
    /// was tapped or pressed to trigger the callout.
    ///
    /// This view requires a button corner radius, since the
    /// style can't provide a dynamic radius.
    struct ButtonArea: View {
        
        /// Create a callout button area.
        ///
        /// - Parameters:
        ///   - frame: The button area frame.
        ///   - buttonCornerRadius: The button corner radius.
        public init(
            frame: CGRect,
            buttonCornerRadius: Double
        ) {
            self.frame = frame
            self.buttonCornerRadius = buttonCornerRadius
        }
        
        private let frame: CGRect
        private let buttonCornerRadius: Double

        @Environment(\.keyboardCalloutStyle)
        private var style
        
        public var body: some View {
            HStack(alignment: .top, spacing: 0) {
                calloutCurveLeading
                buttonBody
                calloutCurveTrailing
            }
        }
    }
}

private extension KeyboardCallout.ActionCallout.ButtonArea {

    var backgroundColor: Color {
        style.backgroundColor
    }

    var curveSize: CGSize {
        style.curveSize
    }

    var buttonBody: some View {
        CustomRoundedRectangle(bottomLeft: buttonCornerRadius, bottomRight: buttonCornerRadius)
            .foregroundColor(backgroundColor)
            .frame(width: frame.size.width, height: frame.size.height)
    }
    
    var calloutCurveLeading: some View {
        LeadingCurve()
            .frame(width: curveSize.width, height: curveSize.height)
            .foregroundColor(backgroundColor)
    }
    
    var calloutCurveTrailing: some View {
        TrailingCurve()
            .frame(width: curveSize.width, height: curveSize.height)
            .foregroundColor(backgroundColor)
    }
}

private extension KeyboardCallout.ActionCallout.ButtonArea {

    struct LeadingCurve: Shape {
        
        public func path(in rect: CGRect) -> Path {
            var path = Path()
            guard rect.isValidForPath else { return path }
            let topTrailing = CGPoint(x: rect.maxX+10, y: rect.minY)
            let topLeading = CGPoint(x: rect.minX, y: rect.minY - 20)
            let btmLeading = CGPoint(x: rect.minX, y: rect.minY - 10)
            let btmTrailing = CGPoint(x: rect.maxX, y: rect.maxY + 10)
            path.move(to: topTrailing)
            path.addLine(to: topLeading)
            path.addLine(to: btmLeading)
            path.addCurve(
                to: btmTrailing,
                control1: .init(x: 0, y: 5),
                control2: .init(x: rect.maxX, y: rect.minY)
            )
            path.addLine(to: topTrailing)
            return path
        }
    }
    
    struct TrailingCurve: Shape {
        
        public func path(in rect: CGRect) -> Path {
            var path = Path()
            guard rect.isValidForPath else { return path }
            let topLeading = CGPoint(x: rect.minX, y: rect.minY)
            let topTrailing = CGPoint(x: rect.maxY, y: rect.minY)
            let btmLeading = CGPoint(x: rect.minX, y: rect.maxY)
            path.move(to: topLeading)
            path.addLine(to: topTrailing)
            path.addCurve(
                to: btmLeading,
                control1: .zero,
                control2: .init(x: 0, y: rect.maxY)
            )
            path.addLine(to: topLeading)
            return path
        }
    }
}

#Preview {

    VStack(alignment: .leading, spacing: 0) {
        RoundedRectangle(cornerRadius: 10)
            .fill(.white)
            .frame(height: 80)
        HStack {
            KeyboardCallout.ActionCallout.ButtonArea(
                frame: CGRect(x: 0, y: 0, width: 50, height: 50),
                buttonCornerRadius: 10
            )
            Spacer()
            KeyboardCallout.ActionCallout.ButtonArea(
                frame: CGRect(x: 0, y: 0, width: 100, height: 50),
                buttonCornerRadius: 20
            ).rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
        }
    }
    .padding()
    .background(Color.keyboardBackground)
    .cornerRadius(20)
    .keyboardCalloutStyle(.standard)
    .padding()
}

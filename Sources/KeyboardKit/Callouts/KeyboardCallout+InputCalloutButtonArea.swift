//
//  KeyboardCallout+InputCalloutButtonArea.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-04-10.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardCallout.InputCallout {

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
                calloutCurve.rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                buttonBody
                calloutCurve
            }
        }
    }
}

private extension KeyboardCallout.InputCallout.ButtonArea {

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
    
    var calloutCurve: some View {
        Curve()
            .frame(width: curveSize.width, height: curveSize.height)
            .foregroundColor(backgroundColor)
    }
}

private extension KeyboardCallout.InputCallout.ButtonArea {

    struct Curve: Shape {
        
        public func path(in rect: CGRect) -> Path {
            var path = Path()
            guard rect.isValidForPath else { return path }
            let curveStart = CGPoint(x: rect.minX, y: rect.maxY)
            let curveStop  = CGPoint(x: rect.maxX, y: rect.minY)
            let corner = CGPoint(x: rect.minY, y: rect.minY)
            path.move(to: curveStart)
            path.addCurve(to: curveStop, control1: .init(x: 0, y: rect.maxY/2), control2: .init(x: 0, y: rect.maxY/2))
            path.addLine(to: corner)
            path.addLine(to: curveStart)
            return path
        }
    }
}

#Preview {
    
    VStack(spacing: 0) {
        RoundedRectangle(cornerRadius: 20)
            .fill(.white)
            .frame(height: 50)
        HStack {
            KeyboardCallout.InputCallout.ButtonArea(
                frame: CGRect(x: 0, y: 0, width: 50, height: 50),
                buttonCornerRadius: 10
            )
            KeyboardCallout.InputCallout.ButtonArea(
                frame: CGRect(x: 0, y: 0, width: 100, height: 50),
                buttonCornerRadius: 20
            )
        }
    }
    .padding()
    .background(Color.keyboardBackground)
    .cornerRadius(20)
    .keyboardCalloutStyle(.standard)
    .padding()
}

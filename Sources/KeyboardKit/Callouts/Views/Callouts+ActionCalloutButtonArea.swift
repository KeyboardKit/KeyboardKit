//
//  Callouts+ActionCalloutButtonArea.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-04-10.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Callouts.ActionCallout {
    
    /// This view is used to cover the part of a button that
    /// was tapped or pressed to trigger the callout.
    struct ButtonArea: View {
        
        /// Create a callout button area.
        ///
        /// - Parameters:
        ///   - frame: The button area frame.
        public init(
            frame: CGRect
        ) {
            self.frame = frame
        }
        
        private let frame: CGRect

        private typealias Style = Callouts.CalloutStyle

        @Environment(\.calloutStyle)
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

private extension Callouts.ActionCallout.ButtonArea {
    
    var backgroundColor: Color { style.backgroundColor }
    var cornerRadius: CGFloat { style.buttonOverlayCornerRadius }
    var curveSize: CGSize { style.curveSize }
    
    var buttonBody: some View {
        CustomRoundedRectangle(bottomLeft: cornerRadius, bottomRight: cornerRadius)
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

private extension Callouts.ActionCallout.ButtonArea {
    
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
            path.addCurve(to: btmTrailing, control1: .init(x: 0, y: 5), control2: .init(x: rect.maxX, y: rect.minY))
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
            path.addCurve(to: btmLeading, control1: .zero, control2: .init(x: 0, y: rect.maxY))
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
        Callouts.ActionCallout.ButtonArea(
            frame: CGRect(x: 0, y: 0, width: 50, height: 50)
        )
    }
    
    .padding(30)
    .background(Color.keyboardBackground)
    .cornerRadius(20)
    .calloutStyle(.standard)
}

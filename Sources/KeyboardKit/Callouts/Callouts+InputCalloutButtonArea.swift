//
//  Callouts+ButtonArea.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-04-10.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Callouts.InputCallout {
    
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
            self.initStyle = nil
        }
        
        private let frame: CGRect
        
        @Environment(\.calloutStyle)
        private var envStyle
        
        public var body: some View {
            HStack(alignment: .top, spacing: 0) {
                calloutCurve.rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                buttonBody
                calloutCurve
            }
        }
        
        // MARK: - Deprecated
        
        @available(*, deprecated, message: "Use .calloutStyle to apply the style instead.")
        public init(
            frame: CGRect,
            style: Callouts.CalloutStyle = .standard
        ) {
            self.frame = frame
            self.initStyle = style
        }
        
        private typealias Style = Callouts.CalloutStyle
        private let initStyle: Style?
        private var style: Style { initStyle ?? envStyle }
    }
}

private extension Callouts.InputCallout.ButtonArea {
    
    var backgroundColor: Color { style.backgroundColor }
    var cornerRadius: CGFloat { style.buttonCornerRadius }
    var curveSize: CGSize { style.curveSize }
    
    var buttonBody: some View {
        CustomRoundedRectangle(bottomLeft: cornerRadius, bottomRight: cornerRadius)
            .foregroundColor(backgroundColor)
            .frame(width: frame.size.width, height: frame.size.height)
    }
    
    var calloutCurve: some View {
        Curve()
            .frame(width: curveSize.width, height: curveSize.height)
            .foregroundColor(backgroundColor)
    }
}

private extension Callouts.InputCallout.ButtonArea {
    
    struct Curve: Shape {
        
        public func path(in rect: CGRect) -> Path {
            var path = Path()
            guard rect.isValidForPath else { return path }
            let curveStart = CGPoint(x: rect.minX, y: rect.maxY)
            let curveStop  = CGPoint(x: rect.maxX, y: rect.minY)
            let corner = CGPoint(x: rect.minY, y: rect.minY)
            path.move(to: curveStart)
            path.addCurve(to: curveStop, control1: .init(x: 0, y: rect.maxY/2), control2: .zero)
            path.addLine(to: curveStop)
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
        Callouts.InputCallout.ButtonArea(
            frame: CGRect(x: 0, y: 0, width: 50, height: 50)
        )
    }
    .padding(30)
    .background(Color.gray)
    .cornerRadius(20)
    // .calloutStyle(.preview1)
}

//
//  CalloutCurve.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-08.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import SwiftUI

public extension Callouts {
    
    /// This curve is used to smoothen the part of a callout,
    /// where the callout body meets the button area.
    struct Curve: Shape {
        
        public func path(in rect: CGRect) -> Path {
            var path = Path()
            guard rect.isValidForPath else { return path }
            let curveStart = CGPoint(x: rect.minX, y: rect.maxY)
            let curveStop  = CGPoint(x: rect.maxX, y: rect.minY)
            let corner = CGPoint(x: rect.minY, y: rect.minY)
            path.move(to: curveStart)
            path.addCurve(to: curveStop, control1: .init(x: rect.minX, y: rect.maxY - rect.minY), control2: .zero)
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
        HStack(alignment: .top, spacing: 0) {
            Callouts.Curve().rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                .frame(height: 20)
            Color.black
            Callouts.Curve()
                .frame(height: 20)
        }.frame(width: 100, height: 50)
    }
    .frame(height: 100)
    .padding()
}

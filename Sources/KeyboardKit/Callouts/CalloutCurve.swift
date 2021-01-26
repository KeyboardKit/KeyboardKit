//
//  CalloutCurve.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-08.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import SwiftUI

/**
 This shape can be used to smoothen the parts of the callout
 bubbles that consist of a callout part and a button shape.
 */
public struct CalloutCurve: Shape {
    
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

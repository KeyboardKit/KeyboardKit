import CoreGraphics
import SwiftUI

public extension Callouts {
    
    @available(*, deprecated, message: "This shape has been replaced by callout-specific curve shapes.")
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

//
//  CustomRoundedRectangle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-05.
//
//  Original solution by @kontiki at:
//  https://stackoverflow.com/questions/56760335/round-specific-corners-swiftui
//

import SwiftUI

/**
 This shape is a rounded rectangle where every corner can be
 given a custom corner radius.
 
 The shape is internal, since it's just an internal tool. It
 is not a public part of KeyboardKit.
 */
struct CustomRoundedRectangle: Shape {
    
    init(
        topLeft: CGFloat = 0.0,
        topRight: CGFloat = 0.0,
        bottomLeft: CGFloat = 0.0,
        bottomRight: CGFloat = 0.0
    ) {
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomLeft = bottomLeft
        self.bottomRight = bottomRight
    }
    
    private let topLeft: CGFloat
    private let topRight: CGFloat
    private let bottomLeft: CGFloat
    private let bottomRight: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        guard rect.isValidForPath else { return path }
        
        let width = rect.size.width
        let height = rect.size.height
        let topLeft = min(min(self.topLeft, height/2), width/2)
        let topRight = min(min(self.topRight, height/2), width/2)
        let bottomLeft = min(min(self.bottomLeft, height/2), width/2)
        let bottomRight = min(min(self.bottomRight, height/2), width/2)
        
        path.move(to: CGPoint(x: width / 2.0, y: 0))
        path.addLine(to: CGPoint(x: width - topRight, y: 0))
        path.addArc(
            center: CGPoint(x: width - topRight, y: topRight),
            radius: topRight,
            startAngle: Angle(degrees: -90),
            endAngle: Angle(degrees: 0), clockwise: false)
        path.addLine(to: CGPoint(x: width, y: height - bottomRight))
        path.addArc(
            center: CGPoint(x: width - bottomRight, y: height - bottomRight),
            radius: bottomRight,
            startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90),
            clockwise: false)
        path.addLine(to: CGPoint(x: bottomLeft, y: height))
        path.addArc(
            center: CGPoint(x: bottomLeft, y: height - bottomLeft),
            radius: bottomLeft,
            startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180),
            clockwise: false)
        path.addLine(to: CGPoint(x: 0, y: topLeft))
        path.addArc(
            center: CGPoint(x: topLeft, y: topLeft),
            radius: topLeft,
            startAngle: Angle(degrees: 180),
            endAngle: Angle(degrees: 270), clockwise: false)
        return path
    }
}

struct CustomRoundedRectangle_Previews: PreviewProvider {
    
    static var previews: some View {
        CustomRoundedRectangle(topLeft: 10, topRight: 20, bottomLeft: 30, bottomRight: 40)
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            .padding()
            .background(Color.red)
            .frame(width: 200, height: 200)
    }
}

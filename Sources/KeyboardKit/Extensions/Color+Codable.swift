//
//  Color+Codable.swift
//  SwiftUIKit
//
//  Created by Daniel Saidi on 2021-08-23.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

//  This extension makes `Color` implement `Codable`.
//
//  Original implementation:
//  https://brunowernimont.me/howtos/make-swiftui-color-codable

import SwiftUI

#if os(iOS)
import UIKit
#elseif os(watchOS)
import WatchKit
#elseif os(macOS)
import AppKit
#endif

/**
 This extension extends `Color` with `Codable` functionality.
 */
@available(iOS 14, macOS 11, tvOS 14, watchOS 7, *)
extension Color: Codable {
    
    enum CodingKeys: String, CodingKey {
        case red, green, blue, alpha
    }

    /**
     Initialize a color value from a decoder.
     */
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let r = try container.decode(Double.self, forKey: .red)
        let g = try container.decode(Double.self, forKey: .green)
        let b = try container.decode(Double.self, forKey: .blue)
        let a = try container.decode(Double.self, forKey: .alpha)
        self.init(red: r, green: g, blue: b, opacity: a)
    }

    /**
     Encode the color, using an encoder.

     Note that encoding dynamic colors that support features
     like dark mode, high contrast etc. will cause the color
     value that is encoded to only contain the current color
     information.
     */
    public func encode(to encoder: Encoder) throws {
        guard let colorComponents = self.colorComponents else { return }
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(colorComponents.red, forKey: .red)
        try container.encode(colorComponents.green, forKey: .green)
        try container.encode(colorComponents.blue, forKey: .blue)
        try container.encode(colorComponents.alpha, forKey: .alpha)
    }
}

@available(iOS 14, macOS 11, tvOS 14, watchOS 7, *)
private extension Color {
    
    #if os(macOS)
    typealias SystemColor = NSColor
    #else
    typealias SystemColor = UIColor
    #endif
    
    var colorComponents: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        #if os(macOS)
        SystemColor(self).getRed(&r, green: &g, blue: &b, alpha: &a)
        // Note that non RGB color will raise an exception, that I don't now how to catch because it is an Objc exception.
        #else
        guard SystemColor(self).getRed(&r, green: &g, blue: &b, alpha: &a) else {
            // Pay attention that the color should be convertible into RGB format
            // Colors using hue, saturation and brightness won't work
            return nil
        }
        #endif
        
        return (r, g, b, a)
    }
}

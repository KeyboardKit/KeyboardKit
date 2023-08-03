//
//  //  KeyboardStyle+Background.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-18.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardStyle {
    
    /**
     This general background style can be used to define the
     background of a keyboard or any components within it.
     
     The style has many layers, which should be applied from
     the bottom to the top, starting with a background color
     and gradient, then an image, then finally some overlays.
     All these layers are optional.
     
     You can use the ``backgroundView`` property to create a
     view with all the layers, applied in the intended order.
     
     The ``standard`` style value can be used to get and set
     the global default style.
     */
    struct Background: Codable, Equatable {
        
        /**
         Create a background style with optional components.
         
         - Parameters:
           - backgroundColor: A background color to apply, by default `nil`.
           - backgroundGradient: A background gradient color set, by default `nil`.
           - imageData: Optional image data that can be used to create a background image, by default `nil`.
           - overlayColor: An overlay color to apply, by default `nil`.
           - overlayGradient: An overlay gradient color set, by default `nil`.
         */
        public init(
            backgroundColor: Color? = nil,
            backgroundGradient: [Color]? = nil,
            imageData: Data? = nil,
            overlayColor: Color? = nil,
            overlayGradient: [Color]? = nil
        ) {
            self.backgroundColor = backgroundColor
            self.backgroundGradient = backgroundGradient
            self.imageData = imageData
            self.overlayColor = overlayColor
            self.overlayGradient = overlayGradient
        }
        
        @available(*, deprecated, message: "Use the component initializer instead.")
        public init(_ type: KeyboardBackgroundType) {
            self.backgroundType = type
            self.legacyBackgroundType = type
        }
        
        private var legacyBackgroundType: KeyboardBackgroundType = .none
        
        @available(*, deprecated, message: "Use the component properties instead.")
        public var backgroundType: KeyboardBackgroundType = .none
        
        
        /// A background color to apply.
        public var backgroundColor: Color?
        
        /// A background gradient color set.
        public var backgroundGradient: [Color]?
        
        /// Optional image data that can be used to create a background image.
        public var imageData: Data?
        
        /// An overlay color to apply.
        public var overlayColor: Color?
        
        /// An overlay gradient color set.
        public var overlayGradient: [Color]?
    }
}

public extension KeyboardStyle.Background {

    /**
     The standard button border style.

     This can be changed to affect the global, default style.
     */
    static var standard = Self()

    /**
     Create a background style with a single color.
     */
    static func color(_ color: Color) -> Self {
        .init(backgroundColor: color)
    }

    /**
     Create a background style with a single image.
     */
    static func image(_ data: Data) -> Self {
        .init(imageData: data)
    }

    /**
     Create a background style with a vertical gradient.
     */
    static func verticalGradient(_ colors: [Color]) -> Self {
        .init(backgroundGradient: colors)
    }

    /**
     Create a background view that uses all style properties.
     */
    @ViewBuilder
    var backgroundView: some View {
        if legacyBackgroundType != .none {
            legacyBackgroundType.internalView
        } else {
            ZStack {
                backgroundColor
                if let backgroundGradient {
                    LinearGradient(colors: backgroundGradient, startPoint: .top, endPoint: .bottom)
                }
                image(from: imageData)?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                if let overlayGradient {
                    LinearGradient(colors: overlayGradient, startPoint: .top, endPoint: .bottom)
                }
                overlayColor
            }
        }
    }
}

private extension KeyboardStyle.Background {

    func image(from data: Data?) -> Image? {
        guard let data else { return nil }
        #if canImport(UIKit)
        let image: UIImage = UIImage(data: data) ?? UIImage()
        return Image(uiImage: image)
        #elseif canImport(AppKit)
        let image: NSImage = NSImage(data: data) ?? NSImage()
        return Image(nsImage: image)
        #else
        return Image(systemImage: "exclamationmark.triangle")
        #endif
    }
}

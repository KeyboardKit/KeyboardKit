//
//  KeyboardStyle+Background.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-18.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
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
           - imageData: Optional image data for a background image, by default `nil`.
           - imageContentMode: The background image content mode, by default `.fill`.
           - overlayColor: An overlay color to apply, by default `nil`.
           - overlayGradient: An overlay gradient color set, by default `nil`.
         */
        public init(
            backgroundColor: Color? = nil,
            backgroundGradient: [Color]? = nil,
            imageData: Data? = nil,
            imageContentMode: ImageContentMode = .fill,
            overlayColor: Color? = nil,
            overlayGradient: [Color]? = nil
        ) {
            self.backgroundColor = backgroundColor
            self.backgroundGradient = backgroundGradient
            self.imageData = imageData
            self.imageContentMode = imageContentMode
            self.overlayColor = overlayColor
            self.overlayGradient = overlayGradient
        }
        
        
        /// This enum contains codable mode representations.
        public enum ImageContentMode: String, Codable {
            case stretch, fill, fit
            
            var nativeMode: ContentMode? {
                switch self {
                case .stretch: return nil
                case .fill: return .fill
                case .fit: return .fit
                }
            }
        }
        
        /// A background color to apply.
        public var backgroundColor: Color?
        
        /// A background gradient color set.
        public var backgroundGradient: [Color]?
        
        /// Optional image data for a background image.
        public var imageData: Data?
        
        /// An optional image content mode.
        public var imageContentMode: ImageContentMode
        
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

    /// Create a background style with a single color.
    static func color(_ color: Color) -> Self {
        .init(backgroundColor: color)
    }
    
    /// Create a background style with a single image.
    static func image(_ data: Data, contentMode: ImageContentMode = .fill) -> Self {
        .init(
            imageData: data,
            imageContentMode: contentMode
        )
    }
    
    #if os(iOS) || os(tvOS) || os(watchOS)
    /// Create a background style with a single image.
    static func image(_ image: UIImage?, contentMode: ImageContentMode = .fill) -> Self {
        .init(
            imageData: image?.pngData() ?? Data(),
            imageContentMode: contentMode
        )
    }
    
    /// Create a background style with a single image.
    static func image(systemName: String, contentMode: ImageContentMode = .fill) -> Self {
        .image(
            UIImage(systemName: "face.smiling"),
            contentMode: contentMode
        )
    }
    #endif

    /// Create a background style with a vertical gradient.
    static func verticalGradient(_ colors: [Color]) -> Self {
        .init(backgroundGradient: colors)
    }

    /// Create a background view with all style properties.
    @ViewBuilder
    var backgroundView: some View {
        ZStack {
            backgroundColor
            if let backgroundGradient {
                LinearGradient(colors: backgroundGradient, startPoint: .top, endPoint: .bottom)
            }
            image(from: imageData)?
                .resizable()
                .optionalAspectRatio(with: imageContentMode)
            if let overlayGradient {
                LinearGradient(colors: overlayGradient, startPoint: .top, endPoint: .bottom)
            }
            overlayColor
        }
    }
}

private extension View {
    
    @ViewBuilder
    func optionalAspectRatio(
        with mode: KeyboardStyle.Background.ImageContentMode
    ) -> some View {
        if let mode = mode.nativeMode {
            self.aspectRatio(contentMode: mode)
        } else {
            self
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

struct KeyboardStyle_Background_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            KeyboardButton.Key(style: .preview1)
            KeyboardButton.Key(style: .preview2)
            KeyboardButton.Key(style: .previewImage)
        }
        .padding()
        .background(Color.gray)
        .cornerRadius(10)
        .environment(\.sizeCategory, .extraExtraLarge)
    }
}

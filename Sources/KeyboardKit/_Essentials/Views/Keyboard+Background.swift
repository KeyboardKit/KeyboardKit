//
//  Keyboard+Background.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-18.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {
    
    /// This background style can define the background of a
    /// keyboard or any components within.
    ///
    /// This style has many optional layers, which should be
    /// added from the bottom to the top. A background color,
    /// a gradient, an image, then some overlays.
    ///
    /// Since the style implements `View`, you can render it
    /// directly into any view hierarchy.
    ///
    /// You can use the ``standard`` style or your own style.
    struct Background: Codable, Equatable, View {
        
        /// Create a keyboard button background style.
        ///
        /// - Parameters:
        ///   - backgroundColor: A background color to apply, by default `nil`.
        ///   - backgroundGradient: A background gradient color set, by default `nil`.
        ///   - imageData: Optional image data for a background image, by default `nil`.
        ///   - imageContentMode: The background image content mode, by default `.fill`.
        ///   - overlayColor: An overlay color to apply, by default `nil`.
        ///   - overlayGradient: An overlay gradient color set, by default `nil`.
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
                case .stretch: nil
                case .fill: .fill
                case .fit: .fit
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
        
        
        public var body: some View {
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
}

public extension Keyboard.Background {

    /// The standard keyboard background style.
    static var standard = Self()

    /// A background style with a single color.
    static func color(
        _ color: Color
    ) -> Self {
        .init(backgroundColor: color)
    }
    
    /// A background style with a single image.
    static func image(
        data: Data,
        contentMode: ImageContentMode = .fill
    ) -> Self {
        .init(
            imageData: data,
            imageContentMode: contentMode
        )
    }
    
    #if canImport(UIKit)
    /// A background style with a single image.
    static func image(
        _ image: UIImage?,
        contentMode: ImageContentMode = .fill
    ) -> Self {
        .init(
            imageData: image?.pngData() ?? Data(),
            imageContentMode: contentMode
        )
    }
    
    /// A background style with a single image.
    static func image(
        systemName: String,
        contentMode: ImageContentMode = .fill
    ) -> Self {
        .image(
            UIImage(systemName: systemName),
            contentMode: contentMode
        )
    }
    #endif

    /// A background style with a vertical gradient.
    static func verticalGradient(
        _ colors: [Color]
    ) -> Self {
        .init(backgroundGradient: colors)
    }

    @available(*, deprecated, renamed: "body", message: "This style now implements View and can be used right away")
    var backgroundView: some View {
        body
    }
}

public extension Keyboard.Background {
    
    /// The background color to use to an accesory view that
    /// is docked just above this background.
    var topAccessoryBackgroundColor: some View {
        ZStack {
            backgroundColor
            backgroundGradient?.first
        }
    }
    
    /// The background color to use to an accesory view that
    /// is docked just below this background.
    var bottomAccessoryBackgroundColor: some View {
        ZStack {
            backgroundColor
            backgroundGradient?.last
        }
    }
}


private extension View {
    
    @ViewBuilder
    func optionalAspectRatio(
        with mode: Keyboard.Background.ImageContentMode
    ) -> some View {
        if let mode = mode.nativeMode {
            self.aspectRatio(contentMode: mode)
        } else {
            self
        }
    }
}

private extension Keyboard.Background {

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

#Preview {
    
    VStack {
        Keyboard.Background.color(.red)
        Keyboard.Background.verticalGradient([.red, .blue])
        #if os(macOS)
        #else
        Keyboard.Background.image(systemName: "checkmark")
        #endif
    }
    .padding()
}

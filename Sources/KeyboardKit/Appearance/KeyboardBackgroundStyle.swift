//
//  KeyboardBackgroundStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-18.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This style defines the background of a keyboard.

 This style has many components that can be used to create a
 background view that can then be added as a background to a
 keyboard view. The ``backgroundView`` property returns such
 a view, which applies all properties in a `ZStack`.

 You can modify the ``standard`` style to change the default,
 global background style.
 */
public struct KeyboardBackgroundStyle: Codable, Equatable {

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

public extension KeyboardBackgroundStyle {

    /**
     This standard style mimics the native iOS style.

     This can be set to change the standard value everywhere.
     */
    static var standard = KeyboardBackgroundStyle()

    /**
     Create a background style with a single color.
     */
    static func color(_ color: Color) -> KeyboardBackgroundStyle {
        .init(backgroundColor: color)
    }

    /**
     Create a background style with a single image.
     */
    static func image(_ data: Data) -> KeyboardBackgroundStyle {
        .init(imageData: data)
    }

    /**
     Create a background style with a vertical gradient.
     */
    static func verticalGradient(_ colors: [Color]) -> KeyboardBackgroundStyle {
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

private extension KeyboardBackgroundStyle {

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

//
//  KeyboardBackgroundType.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-18.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This enum defines supported keyboard background types.
 */
public enum KeyboardBackgroundType: Codable, Equatable {

    /// A plain color background.
    case clear

    /// A plain color background.
    case color(Color)

    /// An image background.
    case image(Data)

    /// A vertical gradient with top-to-bottom colors.
    case verticalGradient([Color])
}

public extension KeyboardBackgroundType {

    /**
     The view to use for the background type.
     */
    @ViewBuilder
    var view: some View {
        switch self {
        case .clear: Color.clear
        case .color(let color): color
        case .image(let data): image(from: data)
        case .verticalGradient(let colors): LinearGradient(colors: colors, startPoint: .top, endPoint: .bottom)
        }
    }
}

private extension KeyboardBackgroundType {

    func image(from data: Data) -> Image {
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

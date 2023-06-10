//
//  KeyboardBackgroundType.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-18.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 [DEPRECATED] This enum defines various keyboard backgrounds.

 The type isn't marked with a real deprecation warning since
 it's still being used internally.
 */
public enum KeyboardBackgroundType: Codable, Equatable {

    /// DEPRECATED
    case none

    /// DEPRECATED
    case clear

    /// DEPRECATED
    case color(Color)

    /// DEPRECATED
    case image(Data)

    /// DEPRECATED
    case verticalGradient([Color])
}

public extension KeyboardBackgroundType {

    @available(*, deprecated, message: "Use a KeyboardBackgroundStyle instead.")
    var view: some View {
        internalView
    }
}

extension KeyboardBackgroundType {

    @ViewBuilder
    var internalView: some View {
        switch self {
        case .clear, .none: Color.clear
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

//
//  KeyboardFontType.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-30.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This enum defines supported keyboard fonts.

 This type makes it possible to use fonts in `Codable` types.
 */
public enum KeyboardFontType: Codable, Equatable {

    case body
    case callout
    case caption
    case caption2
    case custom(_ name: String, size: CGFloat)
    case customFixed(_ name: String, size: CGFloat)
    case footnote
    case headline
    case largeTitle
    case subheadline
    case system(size: CGFloat)
    case title
    case title2
    case title3
}

public extension KeyboardFontType {

    /// Get the native font for the font type.
    var font: Font {
        switch self {
        case .body: return .body
        case .callout: return .callout
        case .caption: return .caption
        case .caption2: return .caption2
        case .custom(let name, let size): return .custom(name, size: size)
        case .customFixed(let name, let size): return .custom(name, fixedSize: size)
        case .footnote: return .footnote
        case .headline: return .headline
        case .largeTitle: return .largeTitle
        case .subheadline: return .subheadline
        case .system(let size): return .system(size: size)
        case .title: return .title
        case .title2: return .title2
        case .title3: return .title3
        }
    }
}

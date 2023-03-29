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
public enum KeyboardFontType: Codable {

    case body
    case callout
    case caption
    case caption2
    case largeTitle
    case title
    case title2
    case title3
    case headline
    case subheadline
    case system(size: CGFloat)
    case footnote
}

public extension KeyboardFontType {

    /// Get the native font for the font type.
    var font: Font {
        switch self {
        case .body: return .body
        case .callout: return .callout
        case .caption: return .caption
        case .caption2: return .caption2
        case .largeTitle: return .largeTitle
        case .title: return .title
        case .title2: return .title2
        case .title3: return .title3
        case .headline: return .headline
        case .subheadline: return .subheadline
        case .system(let size): return .system(size: size)
        case .footnote: return .footnote
        }
    }
}

public extension Font {

    /// Get the keyboard font type for the font.
    var keyboardFont: Font {
        switch self {
        case .body: return .body
        case .callout: return .callout
        case .caption: return .caption
        case .caption2: return .caption2
        case .largeTitle: return .largeTitle
        case .title: return .title
        case .title2: return .title2
        case .title3: return .title3
        case .headline: return .headline
        case .subheadline: return .subheadline
        case .footnote: return .footnote
        default: return .body
        }
    }
}

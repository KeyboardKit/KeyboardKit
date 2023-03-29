//
//  KeyboardFontWeight.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-30.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This enum defines supported keyboard font weights.

 This type makes it possible to use fonts in `Codable` types.
 */
public enum KeyboardFontWeight: Codable, Equatable {

    case black
    case bold
    case heavy
    case light
    case medium
    case regular
    case semibold
    case thin
    case ultraLight
}

public extension KeyboardFontWeight {

    /// Get the native font weight for the weight.
    var fontWeight: Font.Weight {
        switch self {
        case .black: return .black
        case .bold: return .bold
        case .heavy: return .heavy
        case .light: return .light
        case .medium: return .medium
        case .regular: return .regular
        case .semibold: return .semibold
        case .thin: return .thin
        case .ultraLight: return .ultraLight
        }
    }
}

public extension Font.Weight {

    /// Get the keyboard font weight for the weight.
    var keyboardWeight: KeyboardFontWeight {
        switch self {
        case .black: return .black
        case .bold: return .bold
        case .heavy: return .heavy
        case .light: return .light
        case .medium: return .medium
        case .regular: return .regular
        case .semibold: return .semibold
        case .thin: return .thin
        case .ultraLight: return .ultraLight
        default: return .regular
        }
    }
}

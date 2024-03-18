//
//  KeyboardFontWeight.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-30.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardFont {
    
    /**
     This enum defines various keyboard font weights, and is
     used to specify fonts in `Codable` types.
     */
    enum FontWeight: Codable, Equatable {

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
}

public extension KeyboardFont.FontWeight {

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
    var keyboardWeight: KeyboardFont.FontWeight {
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

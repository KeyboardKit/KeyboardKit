//
//  KeyboardType+Button.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-09.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardType {
    
    /**
     The type's standard keyboard button font size.
     */
    func standardButtonFontSize(for context: KeyboardContext) -> CGFloat {
        switch self {
        case .alphabetic: return 15
        case .numeric: return 16
        case .symbolic: return 14
        default: return 14
        }
    }
    
    /**
     The type's standard keyboard button image.
     */
    var standardButtonImage: Image? {
        switch self {
        case .email: return .keyboardEmail
        case .emojis:return .keyboardEmoji
        case .images: return .keyboardImages
        default: return nil
        }
    }
    
    /**
     The type's standard keyboard button text.
     */
    func standardButtonText(for context: KeyboardContext) -> String? {
        switch self {
        case .alphabetic: return KKL10n.keyboardTypeAlphabetic.text(for: context)
        case .numeric: return KKL10n.keyboardTypeNumeric.text(for: context)
        case .symbolic: return KKL10n.keyboardTypeSymbolic.text(for: context)
        default: return nil
        }
    }
}

//
//  KeyboardType+Button.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-09.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardType {
    
    /**
     The keyboard type's standard button image.
     */
    var standardButtonImage: Image? {
        switch self {
        case .email: return .keyboardEmail
        case .emojis: return .keyboardEmoji
        case .images: return .keyboardImages
        default: return nil
        }
    }
    
    /**
     The keyboard type's standard button text.
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

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
        case .email: return .email
        case .emojis:return .emoji
        case .images: return .images
        default: return nil
        }
    }
    
    /**
     The type's standard keyboard button text.
     
     `TODO` Localize these texts and convert the property to
     a function that takes a `context`.
     */
    var standardButtonText: String? {
        switch self {
        case .alphabetic: return "ABC"
        case .numeric: return "123"
        case .symbolic: return "#+="
        default: return nil
        }
    }
}

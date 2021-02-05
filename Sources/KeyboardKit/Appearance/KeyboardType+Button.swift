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
     The keyboard type's standard keyboard button image.
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
     The keyboard type's standard keyboard button text.
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

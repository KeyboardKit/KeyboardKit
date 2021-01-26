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
     The standard button image in a system keyboard.
     */
    var standardButtonImage: Image? {
        switch self {
        case .email: return .email
        case .emojis:
            if #available(iOS 14, *) {
                return .emoji
            } else { return nil }
        case .images: return .images
        default: return nil
        }
    }
    
    /**
     The standard button text in a system keyboard.
     */
    var standardButtonText: String? {
        switch self {
        case .emojis: return "☺"
        case .alphabetic: return "ABC"
        case .numeric: return "123"
        case .symbolic: return "#+="
        default: return nil
        }
    }
}

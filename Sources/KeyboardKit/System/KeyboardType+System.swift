//
//  KeyboardType+System.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-02.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 The "system" extensions are just suggestions if you want to
 mimic system keyboards. You do not have to use them in your
 custom keyboards.
 */
public extension KeyboardType {
    
    /**
     The button text that should be used by a system button
     that applies this keyboard type, if any.
     */
    var systemKeyboardButtonText: String? {
        switch self {
        case .alphabetic: return "ABC"
        case .numeric: return "123"
        case .symbolic: return "#+="
        default: return nil
        }
    }
}

//
//  Locale+Keyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-10-10.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Locale {

    /// Whether this locale prefers to replace alternate end
    /// quotation delimiters with begin ones.
    var prefersAlternateQuotationReplacement: Bool {
        if identifier.hasPrefix("en") { return false }
        return true
    }
}

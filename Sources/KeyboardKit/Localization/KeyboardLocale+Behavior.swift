//
//  KeyboardLocale.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-12-20.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardLocale {
    
    /// Whether a locale prefers to replace alternate ending
    /// quotation delimiters with begin ones.
    var prefersAlternateQuotationReplacement: Bool {
        locale.prefersAlternateQuotationReplacement
    }
}

public extension Locale {
    
    /// Whether a locale prefers to replace alternate ending
    /// quotation delimiters with begin ones.
    var prefersAlternateQuotationReplacement: Bool {
        if identifier.hasPrefix("en") { return false }
        return true
    }
}

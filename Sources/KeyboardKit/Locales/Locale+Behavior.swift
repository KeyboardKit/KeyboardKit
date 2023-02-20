//
//  KeyboardLocale+Behavior.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-12-20.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Locale {
    
    /**
     Whether or not the locale prefers to replace any single
     alternate ending quotation delimiters with begin ones.
     */
    var prefersAlternateQuotationReplacement: Bool {
        if identifier.hasPrefix("en") { return false }
        return true
    }
}

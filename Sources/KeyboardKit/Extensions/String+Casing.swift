//
//  String+Casing.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-07-05.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension String {

    /// Whether or not the string is in its lowercased form.
    var isLowercasedWithUppercaseVariant: Bool {
        self == lowercased() && self != uppercased()
    }
    
    /// Whether or not the string is in its uppercased form.
    var isUppercasedWithLowercaseVariant: Bool {
        self == uppercased() && self != lowercased()
    }
}

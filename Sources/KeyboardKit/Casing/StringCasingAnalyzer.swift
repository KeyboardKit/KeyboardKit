//
//  StringCasingAnalyzer.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-07-05.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be used to analyze the casing of a string.

 The protocol is implemented by `String`.
 */
public protocol StringCasingAnalyzer {

    var string: String { get }
}

extension String: StringCasingAnalyzer {

    // var string: String { self } - Implemented elsewhere
}

public extension StringCasingAnalyzer {

    /**
     Whether or not the string is capitalized.
     */
    var isCapitalized: Bool { string == string.capitalized }

    /**
     Whether or not the string is lowercased.

     This only returns true if the string is lowercased, but
     doesn't have an uppercased variant.
     */
    var isLowercased: Bool { string == string.lowercased() && string != string.uppercased() }
    
    /**
     Whether or not the string is uppercased.

     This only returns true if the string is uppercased, but
     doesn't have a lowercased variant.
     */
    var isUppercased: Bool { string == string.uppercased() && string != string.lowercased() }
}

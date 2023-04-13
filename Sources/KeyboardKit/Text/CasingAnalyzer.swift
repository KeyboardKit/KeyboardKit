//
//  CasingAnalyzer.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-07-05.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any type that should be
 able to analyze casing information for strings.

 Implementing the protocol will extend the implementing type
 with functions that use public `String` extensions with the
 same names. While you can use the protocol, the main reason
 for having it is to expose these extensions to DocC.
 */
public protocol CasingAnalyzer {}

public extension CasingAnalyzer {

    /**
     Whether or not the string is capitalized.
     */
    func isCapitalized(_ string: String) -> Bool {
        string.isCapitalized
    }

    /**
     Whether or not the string is lowercased.

     This only returns true if the string is lowercased, but
     doesn't have an uppercased variant.
     */
    func isLowercased(_ string: String) -> Bool {
        string.isLowercased
    }

    /**
     Whether or not the string is uppercased.

     This only returns true if the string is uppercased, but
     doesn't have a lowercased variant.
     */
    func isUppercased(_ string: String) -> Bool {
        string.isUppercased
    }
}


// MARK: - String

public extension String {

    /**
     Whether or not the string is capitalized.
     */
    var isCapitalized: Bool {
        self == capitalized
    }

    /**
     Whether or not the string is lowercased.

     This only returns true if the string is lowercased, but
     doesn't have an uppercased variant.
     */
    var isLowercased: Bool {
        self == lowercased() && self != uppercased()
    }
    
    /**
     Whether or not the string is uppercased.

     This only returns true if the string is uppercased, but
     doesn't have a lowercased variant.
     */
    var isUppercased: Bool {
        self == uppercased() && self != lowercased()
    }
}

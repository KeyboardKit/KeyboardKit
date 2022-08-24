//
//  String+Casing.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-05.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

public extension String {

    /**
     Whether or not the string is capitalized.
     */
    var isCapitalized: Bool { self == capitalized }

    /**
     Whether or not the string is lowercased.
     */
    var isLowercased: Bool { self == lowercased() && self != uppercased() }
    
    /**
     Whether or not the string is uppercased.
     */
    var isUppercased: Bool { self == uppercased() && self != lowercased() }


    /**
     Case-adjust the string for the provided `text`.

     This will match capitalization, uppercase and lowercase
     states in that order, meaning that a single, uppercased
     character is interpreted as capitalized, not uppercased.
     */
    func caseAdjusted(for text: String) -> String {
        if text.isCapitalized {
            return self.capitalized
        }
        if text == text.uppercased() {
            return self.uppercased()
        }
        if text == text.lowercased() {
            return self.lowercased()
        }
        return self
    }
}

public extension Sequence where Iterator.Element == String {
    
    /**
     Return a copy where all nested strings are uppercased.
     */
    func uppercased() -> [Iterator.Element] {
        map { $0.uppercased() }
    }
}

public extension Sequence where Iterator.Element == [String] {
    
    /**
     Returns a copy where all nested strings are uppercased.
     */
    func uppercased() -> [Iterator.Element] {
        map { $0.map { $0.uppercased() } }
    }
}

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
     Whether or not the string is lowercased.
     */
    var isLowercased: Bool { self == lowercased() && self != uppercased() }
    
    /**
     Whether or not the string is uppercased.
     */
    var isUppercased: Bool { self == uppercased() && self != lowercased() }
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

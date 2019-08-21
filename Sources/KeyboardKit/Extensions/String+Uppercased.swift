//
//  String+Uppercased.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-05.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Sequence where Iterator.Element == String {
    
    /**
     
     Returns a copy of the sequence, where all nested strings
     have been uppercased.
     
     */
    func uppercased() -> [Iterator.Element] {
        return map { $0.uppercased() }
    }
}

public extension Sequence where Iterator.Element == [String] {
    
    /**
     
     Returns a copy where all nested arrays are uppercased.
     
     */
    func uppercased() -> [Iterator.Element] {
        return map { $0.map { $0.uppercased() } }
    }
}

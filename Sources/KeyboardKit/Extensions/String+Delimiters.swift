//
//  String+Delimiters.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-18.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

public extension String {
    
    /**
     Whether or not this is a western sentence delimiter.
     */
    var isSentenceDelimiter: Bool {
        Self.sentenceDelimiters.contains(self)
    }
    
    /**
     Whether or not this is a western word delimiter.
     */
    var isWordDelimiter: Bool {
        Self.wordDelimiters.contains(self)
    }
    
    /**
     A list of western sentence delimiters.
     */
    static var sentenceDelimiters: [String] {
        ["!", ".", "?"]
    }
    
    /**
     A list of western word delimiters.
     */
    static var wordDelimiters: [String] {
        sentenceDelimiters + [",", ";", ":", "\n", " "]
    }
}

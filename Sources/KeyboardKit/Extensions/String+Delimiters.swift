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
     
     You can change this list to change how your keyboard is
     handling things like sentence closing, autocomplete etc.
     */
    static var sentenceDelimiters = ["!", ".", "?"]
    
    /**
     A list of western word delimiters.
     
     You can change this list to change how your keyboard is
     handling things like sentence closing, autocomplete etc.
     */
    static var wordDelimiters = ["!", ".", "?", ",", ";", ":", .newline, " "]
}

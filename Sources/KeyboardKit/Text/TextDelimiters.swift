//
//  TextDelimiters.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This class provides various text delimiters.
 */
public final class TextDelimiters {}

public extension TextDelimiters {

    /**
     A list of western sentence delimiters.

     You can change this list to tweak the global delimiters.
     */
    static var sentenceDelimiters = ["!", ".", "?"]

    /**
     A list of western word delimiters.

     You can change this list to tweak the global delimiters.
     */
    static var wordDelimiters = "!.?,;:()[]{}<>".chars + [" ", .newline]
}

//
//  String+Characters.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension String {

    /// A carriage return character.
    static let carriageReturn = "\r"

    /// A new line character.
    static let newline = "\n"

    /// A space character.
    static let space = " "

    /// A tab character.
    static let tab = "\t"

    /// A zero width space character used in some RTL languages.
    static let zeroWidthSpace = "\u{200B}"


    /// A list of mutable, western sentence delimiters.
    static var sentenceDelimiters = ["!", ".", "?"]

    /// A list of mutable, western word delimiters.
    static var wordDelimiters = "!.?,;:()[]{}<>".map(String.init) + [" ", .newline]
}

public extension String {

    /// Whether or not this is a western sentence delimiter.
    var isSentenceDelimiter: Bool {
        Self.sentenceDelimiters.contains(self)
    }

    /// Whether or not this is a western word delimiter.
    var isWordDelimiter: Bool {
        Self.wordDelimiters.contains(self)
    }
}

public extension Collection where Element == String {

    /// A list of mutable western sentence delimiters.
    static var sentenceDelimiters: [String] { String.sentenceDelimiters }

    /// A list of mutable western word delimiters.
    static var wordDelimiters: [String] { String.wordDelimiters }
}

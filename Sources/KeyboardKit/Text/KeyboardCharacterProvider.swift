//
//  KeyboardCharacterProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any type that should be
 able to retrieve special keyboard characters.

 Implementing the protocol will extend the implementing type
 with functions that use public `String` extensions with the
 same name as these extensions. You can use these extensions
 directly and ignore this protocol, but the protocol exposes
 this functionality to the library documentation.
 */
public protocol KeyboardCharacterProvider {}

public extension KeyboardCharacterProvider {

    /// A carriage return character.
    var carriageReturn: String { .carriageReturn }

    /// A new line character.
    var newline: String { .newline }

    /// A space character.
    var space: String { .space }

    /// A tab character.
    var tab: String { .tab }

    /// A zero width space character used in some RTL languages.
    var zeroWidthSpace: String { .zeroWidthSpace }


    /// A list of western sentence delimiters.
    var sentenceDelimiters: [String] { .sentenceDelimiters }

    /// A list of western word delimiters.
    var wordDelimiters: [String] { .wordDelimiters }
}


// MARK: - String

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


    /// A list of mutable western sentence delimiters.
    static var sentenceDelimiters = ["!", ".", "?"]

    /// A list of mutable western word delimiters.
    static var wordDelimiters = "!.?,;:()[]{}<>".chars + [" ", .newline]
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

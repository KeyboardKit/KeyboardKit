//
//  String+Characters.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-26.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
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
}

public extension String {

    /// A list of currently known alphabetic accent switches.
    static let alphabeticAccentSwitches = "’’‘`"
        .chars

    /// A list of currently known autocorrect triggers.
    static var autocorrectTriggers = ".,:;!¡?¿{}<>«»"
        .appending(CharacterSet.whitespacesAndNewlines.toString())
        .chars

    /// A list of currently known sentence delimiters.
    static var sentenceDelimiters = ".:!¡?¿".chars

    /// A list of currently known word delimiters.
    static let wordDelimiters = ".,:;!¡?¿()[]{}<>«»་།"
        .appending(CharacterSet.whitespacesAndNewlines.toString())
        .chars
}

public extension Collection where Element == String {

    /// A list of currently known alphabetic accent switches.
    static var alphabeticAccentSwitches: [String] {
        String.alphabeticAccentSwitches
    }

    /// A list of currently known autocorrect trigger.
    static var autocorrectTriggers: [String] {
        String.autocorrectTriggers
    }

    /// A list of currently known sentence delimiters.
    static var sentenceDelimiters: [String] {
        String.sentenceDelimiters
    }

    /// A list of currently known word delimiters.
    static var wordDelimiters: [String] {
        String.wordDelimiters
    }
}

public extension String {

    /// Whether this is a known alphabetic accent switch.
    var isAlphabeticAccentSwitch: Bool {
        Self.alphabeticAccentSwitches.contains(self)
    }

    /// Whether this is a known autocorrect trigger.
    var isAutocorrectTrigger: Bool {
        Self.autocorrectTriggers.contains(self)
    }

    /// Whether this is a known sentence delimiter.
    var isSentenceDelimiter: Bool {
        Self.sentenceDelimiters.contains(self)
    }

    /// Whether this is a known word delimiter.
    var isWordDelimiter: Bool {
        Self.wordDelimiters.contains(self)
    }
}

private extension CharacterSet {

    func toString() -> String {
        let scalars = (0...0x10FFFF)
            .compactMap(UnicodeScalar.init)
            .filter(self.contains)
        return String(String.UnicodeScalarView(scalars))
    }
}

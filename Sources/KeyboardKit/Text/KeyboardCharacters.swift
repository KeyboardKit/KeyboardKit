//
//  KeyboardCharacters.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This class provides various keyboard-specific characters.
 */
public final class KeyboardCharacters {}

public extension KeyboardCharacters {

    /**
     A carriage return character.
     */
    static let carriageReturn = "\r"

    /**
     A new line character.
     */
    static let newline = "\n"

    /**
     A space character.
     */
    static let space = " "

    /**
     A tab character.
     */
    static let tab = "\t"

    /**
     A zero width space character.

     This character is used in some RTL languages, to add an
     extra invisible space.
     */
    static let zeroWidthSpace = "\u{200B}"
}

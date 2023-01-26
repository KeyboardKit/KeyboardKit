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

 This protocol uses the values in ``KeyboardCharacters`` and
 provides similar properties to its implementing types.

 This protocol is implemented by `String` and other types in
 this library.
 */
public protocol KeyboardCharacterProvider {}

public extension KeyboardCharacterProvider {

    /**
     A carriage return character.
     */
    static var carriageReturn: String { KeyboardCharacters.carriageReturn }

    /**
     A new line character.
     */
    static var newline: String { KeyboardCharacters.newline }

    /**
     A space character.
     */
    static var space: String { KeyboardCharacters.space }

    /**
     A tab character.
     */
    static var tab: String { KeyboardCharacters.tab }

    /**
     A zero width space character.

     This character is used in some RTL languages, to add an
     extra invisible space.
     */
    static var zeroWidthSpace: String { KeyboardCharacters.zeroWidthSpace }
}


// MARK: - Implementations

extension String: KeyboardCharacterProvider {}

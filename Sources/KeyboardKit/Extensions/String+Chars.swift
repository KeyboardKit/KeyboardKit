//
//  String+Chars.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-03.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

public extension String {
    
    /**
     Split the string into a list of individual characters.
     */
    var chars: [String] { map { String($0) } }
    
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

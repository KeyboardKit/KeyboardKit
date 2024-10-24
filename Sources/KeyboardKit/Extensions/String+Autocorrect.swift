//
//  String+Autocorrect.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-10-24.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension String {
    
    /// A list of known autocorrect triggers.
    ///
    /// Instead of using a character set-based way to define
    /// delimiters, let's append missing ones as we find any. 
    static var autocorrectTriggers = ".,:;!¡?¿{}<>«»"
        .appending(CharacterSet.whitespacesAndNewlines.toString())
        .chars

    /// Whether or not this is a known autocorrect trigger.
    var isAutocorrectTrigger: Bool {
        Self.autocorrectTriggers.contains(self)
    }
}

public extension Collection where Element == String {

    /// A list of known autocorrect trigger.
    static var autocorrectTriggers: [String] {
        String.autocorrectTriggers
    }
}

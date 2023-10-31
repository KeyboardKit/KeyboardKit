//
//  String+Chars.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-11-01.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension String {
    
    /// Split the string into a list of characters.
    var chars: [String] { map(String.init) }
}

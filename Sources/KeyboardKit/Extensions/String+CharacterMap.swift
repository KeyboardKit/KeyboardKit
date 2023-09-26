//
//  String+CharacterMap.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-03.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension String {
    
    /// Split the string into a list of characters.
    var chars: [String] { map(String.init) }
}

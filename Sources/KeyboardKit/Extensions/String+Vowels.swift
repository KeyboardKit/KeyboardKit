//
//  String+Vowels.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-11-14.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

public extension String {
    
    /**
     Whether or not this is a western vowel.
     */
    var isVowel: Bool {
        Self.vowels.contains(self.lowercased())
    }
    
    /**
     A list of western vowels.
     
     You can change the list if you find it to be incomplete.
     If you do, please consider sending a PR with the change.
     */
    static var vowels = "aeiouüyåäæöø"
}

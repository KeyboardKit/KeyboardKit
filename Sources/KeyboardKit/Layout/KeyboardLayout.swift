//
//  KeyboardLayout.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-03.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 A keyboard layout lists all available actions on a keyboard.
 It's most often made up of multiple input button rows and a
 set of surrounding system system buttons.
 
 A keyboard layout depends on the current locale, device and
 orientation etc. It's therefore more complicated to resolve
 a layout than an input set. Us
 */
public class KeyboardLayout: Equatable {
    
    public init(actionRows: KeyboardActionRows) {
        self.actionRows = actionRows
    }
    
    public let actionRows: KeyboardActionRows
    
    public static func == (lhs: KeyboardLayout, rhs: KeyboardLayout) -> Bool {
        lhs.actionRows == rhs.actionRows
    }
}

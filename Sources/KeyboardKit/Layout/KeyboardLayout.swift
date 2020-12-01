//
//  KeyboardLayout.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-03.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 A "keyboard layout" represents the total set of actions for
 a keyboard. This normally consists of rows of input buttons
 surrounded by system buttons on some or all rows.
 
 Keyboard layouts depends on the current locale, the current
 device and orientation, whether or not it has a home button
 etc. This makes it more complicated to resolve layouts than
 input sets, since input sets just rely on a locale.
 
 As such, there is no `KeyboardLayout+Locale` extension. You
 must instead use a `KeyboardLayoutProvider`, which lets you
 resolve keyboard layouts in a more abstract way.
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

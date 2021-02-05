//
//  KeyboardLayout.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-03.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 Keyboard layouts list available actions on a keyboard. They
 most often consist of multiple input button rows surrounded
 by system buttons.
 */
public class KeyboardLayout: Equatable {
    
    public init(rows: KeyboardActionRows) {
        self.rows = rows
    }
    
    public let rows: KeyboardActionRows
    
    public static func == (lhs: KeyboardLayout, rhs: KeyboardLayout) -> Bool {
        lhs.rows == rhs.rows
    }
}

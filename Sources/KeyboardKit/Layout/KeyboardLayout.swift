//
//  KeyboardLayout.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-03.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import SwiftUI

/**
 Keyboard layouts list available actions on a keyboard. They
 most often consist of multiple input button rows surrounded
 by system buttons, as well as size information.
 */
public class KeyboardLayout {
    
    public init(
        rows: KeyboardActionRows,
        items: KeyboardLayoutItemRows,
        buttonHeight: CGFloat,
        buttonInsets: EdgeInsets) {
        self.rows = rows
        self.items = items
        self.buttonHeight = buttonHeight
        self.buttonInsets = buttonInsets
    }
    
    public let buttonHeight: CGFloat
    public let buttonInsets: EdgeInsets
    public let items: KeyboardLayoutItemRows
    public let rows: KeyboardActionRows
}

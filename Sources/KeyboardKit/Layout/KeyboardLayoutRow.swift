//
//  KeyboardLayoutRow.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-03.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import SwiftUI

/**
 A keyboard layout row contains a list of layout items.
 */
public struct KeyboardLayoutRow: Equatable {
    
    public init(
        items: [KeyboardLayoutItem]) {
        self.items = items
    }
    
    public let items: [KeyboardLayoutItem]
}

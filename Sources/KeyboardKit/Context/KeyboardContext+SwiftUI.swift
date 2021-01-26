//
//  KeyboardContext+SwiftUI.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-13.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardContext {
    
    /**
     The keyboard extension's current color scheme, which is
     derived from the controller's `userInterfaceStyle`.
     */
    var colorScheme: ColorScheme {
        let style = traitCollection.userInterfaceStyle
        return style == .dark ? .dark : .light
    }
}

//
//  View+Keyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-29.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {
    
    /**
     Get the current keyboard view controller.
     */
    var keyboardInputViewController: KeyboardInputViewController { .shared }
    
    /**
     Get the current keyboard view controller.
     */
    static var keyboardInputViewController: KeyboardInputViewController { .shared }
}

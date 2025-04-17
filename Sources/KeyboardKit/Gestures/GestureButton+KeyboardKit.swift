//
//  GestureButton+KeyboardKit.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-04-17.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {
    
    /// Customize the keyboard button gesture configuration.
    func keyboardButtonGestureConfiguration(
        _ config: GestureButtonConfiguration
    ) -> some View {
        self.gestureButtonConfiguration(config)
    }
}

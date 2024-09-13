//
//  GestureButtonDefaults.swift
//  GestureButton
//
//  Created by Daniel Saidi on 2022-11-24.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This struct is used to configure gesture button defaults.
struct GestureButtonDefaults {

    /// The time to wait before checking if the gesture was silently cancelled.
    static let cancelDelay = 3.0

    /// The max time between two taps for them to count as a double tap.
    static let doubleTapTimeout = 0.2

    /// The time it takes for a press to count as a long press.
    static let longPressDelay = 0.5

    /// The time it takes for a press to count as a repeat trigger.
    static let repeatDelay = 0.5
}

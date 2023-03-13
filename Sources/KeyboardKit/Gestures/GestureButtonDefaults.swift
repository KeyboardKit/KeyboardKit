//
//  GestureButtonDefaults.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-11-24.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This struct can be used to configure default values for the
 ``GestureButton`` and ``ScrollViewGestureButton`` views.
 */
public struct GestureButtonDefaults {

    /// The max time between two taps for them to count as a double tap, by default `0.2`.
    public static var doubleTapTimeout = 0.2

    /// The time it takes for a press to count as a long press, by default `0.5`.
    public static var longPressDelay = 0.5

    /// The time it takes for a press to count as a repeat trigger, by default `0.5`.
    public static var repeatDelay = 0.5
}

//
//  DisabledHapticFeedbackEngine.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-01-19.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This disabled engine doesn't do anything and can be used on
 platforms where system haptics are not available.
 */
public class DisabledHapticFeedbackEngine: HapticFeedbackEngine {
    
    /**
     Create a disabled engine.
     */
    public init() {}

    public func prepare(_ feedback: HapticFeedback) {}
    public func trigger(_ feedback: HapticFeedback) {}
}

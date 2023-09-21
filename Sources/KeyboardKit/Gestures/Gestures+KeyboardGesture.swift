//
//  Gestures+KeyboardGesture.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2019-2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Gestures {
 
    /**
     This enum defines various keyboard gestures that can be
     used to interact with a keyboard.
     */
    enum KeyboardGesture: String, CaseIterable, Codable, Equatable, Identifiable {

        /// Triggers when a button is double tapped.
        case doubleTap
        
        /// Triggers when a button is pressed down.
        case press

        /// Triggers when a button is released.
        case release
        
        /// Triggers when a button is long pressed.
        case longPress

        /// Triggers repeatedly when a button is pressed & held.
        case repeatPress
    }
}

public extension Gestures.KeyboardGesture {
    
    /// The gesture's unique identifier.
    var id: String { rawValue }
}

//
//  KeyboardGesture.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2019-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum defines the various ways a user can interact with
 keyboard actions, using KeyboardKit's built-in interactions.
 */
public enum KeyboardGesture: String, CaseIterable, Codable, Equatable, Identifiable {

    /// Occurs when a button is double tapped.
    case doubleTap
    
    /// Occurs when a button is pressed down.
    case press
    
    /// Occurs when a button is released, inside or outside.
    case release
    
    /// Occurs when a button is long pressed.
    case longPress
    
    /// Occurs repeatedly when a button is pressed and held.
    case repeatPress
}

public extension KeyboardGesture {
    
    /**
     The gesture's unique identifier.
     */
    var id: String { rawValue }
}

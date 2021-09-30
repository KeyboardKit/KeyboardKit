//
//  KeyboardGesture.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum defines the various ways a user can interact with
 keyboard actions, using KeyboardKit's built-in interactions.
 */
public enum KeyboardGesture: CaseIterable, Codable, Equatable {

    /// Occurs when a button is pressed then released inside
    case tap
    
    /// Occurs when a button is double tapped
    case doubleTap
    
    /// Occurs when a button is pressed down
    case press
    
    /// Occurs when a button is released, inside or outside
    case release
    
    /// Occurs when a button is long pressed
    case longPress
    
    /// Occurs repeatedly when a button is pressed and held
    case repeatPress
}

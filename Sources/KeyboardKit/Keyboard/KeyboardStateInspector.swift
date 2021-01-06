//
//  KeyboardStateInspector.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-05-05.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any class or struct and
 provides any implementations with state-specific extensions.
 
 You just have to implement the protocol to give a class the
 `isKeyboardEnabled` functionality.
 */
public protocol KeyboardStateInspector {}

public extension KeyboardStateInspector {
    
    /**
     Check if a certain keyboard extension is enabled.
     
     When you call this function, make sure that you use the
     `bundleId` of the *keyboard extension* and not the app.
     */
    func isKeyboardEnabled(
        for bundleId: String,
        defaults: UserDefaults = .standard) -> Bool {
        let key = "AppleKeyboards"
        guard let settings = defaults.object(forKey: key) as? [String] else { return false }
        return settings.contains(bundleId)
    }
}

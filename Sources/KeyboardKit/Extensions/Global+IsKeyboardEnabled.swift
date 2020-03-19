//
//  Global+IsKeyboardEnabled.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-19.
//

import Foundation

/**
 Check if a certain keyboard extension is enabled.
 
 When calling this function, make sure to use the `bundleId`
 of the *keyboard extension* and not the app's.
 */
public func isKeyboardEnabled(
    _ bundleId: String,
    defaults: UserDefaults = .standard) -> Bool {
    let key = "AppleKeyboards"
    guard let settings = defaults.object(forKey: key) as? [String] else { return false }
    return settings.contains(bundleId)
}

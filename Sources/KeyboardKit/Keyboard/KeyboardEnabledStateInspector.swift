//
//  KeyboardEnabledStateInspector.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-05-05.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation
import UIKit

/**
 This protocol can be implemented by any class or struct and
 provides its implementations with state-specific extensions.
 
 However, the easiest way to observe the enabled state is to
 just create an `KeyboardEnabledState` instance.
 */
public protocol KeyboardEnabledStateInspector {}

public extension KeyboardEnabledStateInspector {
    
    /**
     Check whether or not the app has been given full access
     in System Settings.
     */
    var isFullAccessEnabled: Bool {
        FullAccessCheckController().hasFullAccess
    }
    
    /**
     Check whether or not a certain keyboard extension is enabled.
     
     When you call this function, make sure that you use the
     `bundleId` of the keyboard extension, not the app.
     
     - Parameter bundleId: The bundle id of the keyboard extension.
     - Parameter notificationCenter: The notification center to use to observe changes.     
     */
    func isKeyboardEnabled(
        withBundleId bundleId: String, 
        defaults: UserDefaults = .standard) -> Bool {
        let key = "AppleKeyboards"
        guard let settings = defaults.object(forKey: key) as? [String] else { return false }
        return settings.contains(bundleId)
    }
}

private class FullAccessCheckController: UIInputViewController {}

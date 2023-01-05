//
//  KeyboardEnabledStateInspector.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-05-05.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
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
        FullAccessInspector().hasFullAccess
    }
    
    /**
     Whether or not the keyboard extension with the provided
     `bundleId` is currently being used in a text field.
     
     - Parameter withBundleId: The bundle id of the keyboard extension.
     */
    func isKeyboardActive(
        withBundleId bundleId: String
    ) -> Bool {
        let modes = UITextInputMode.activeInputModes
        let displayedModes = modes.filter { $0.value(forKey: "isDisplayed") as? Int == 1 }
        let id = displayedModes.map { $0.value(forKey: "identifier") as? String }
        return bundleId == id.first
    }
    
    /**
     Whether or not the keyboard extension with the provided
     `bundleId` has been enabled in System Settings.
     
     - Parameter withBundleId: The bundle id of the keyboard extension.
     - Parameter defaults: The user defaults instance to check.     
     */
    func isKeyboardEnabled(
        withBundleId bundleId: String,
        defaults: UserDefaults = .standard
    ) -> Bool {
        let key = "AppleKeyboards"
        guard let settings = defaults.object(forKey: key) as? [String] else { return false }
        return settings.contains(bundleId)
    }
}

private class FullAccessInspector: UIInputViewController {}
#endif

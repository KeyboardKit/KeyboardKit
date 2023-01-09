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
 This protocol can be implemented by any type that should be
 able to check the enabled state of keyboard extensions.

 This type makes it easy to check if a keyboard extension is
 enabled (in System Settings) and if it is active (currently
 being used to type).
 
 However, the easiest way to observe the state of a keyboard
 extension is to just use a ``KeyboardEnabledState``.
 */
public protocol KeyboardEnabledStateInspector {}

public extension KeyboardEnabledStateInspector {

    /**
     Get a list of all active keyboard bundle identifiers.
     */
    var activeKeyboardBundleIds: [String] {
        let modes = UITextInputMode.activeInputModes
        let displayed = modes.filter { $0.value(forKey: "isDisplayed") as? Int == 1 }
        let ids = displayed.compactMap { $0.value(forKey: "identifier") as? String }
        return ids
    }

    /**
     Get a list of all enabled keyboard bundle identifiers.

     - Parameters:
       - defaults: The user defaults instance to use, by default `.standard`.
     */
    func enabledKeyboardBundleIds(
        defaults: UserDefaults = .standard
    ) -> [String] {
        let key = "AppleKeyboards"
        return defaults.object(forKey: key) as? [String] ?? []
    }
    
    /**
     Check whether or not the app has been given full access
     in System Settings.
     */
    var isFullAccessEnabled: Bool {
        FullAccessInspector().hasFullAccess
    }
    
    /**
     Whether or not a certain keyboard extension is active.
     
     - Parameter withBundleId: The bundle id of the keyboard extension.
     */
    func isKeyboardActive(
        withBundleId bundleId: String
    ) -> Bool {
        bundleId == activeKeyboardBundleIds.first
    }
    
    /**
     Whether or not a certain keyboard extension is enabled.

     - Parameters:
       - withBundleId: The bundle id of the keyboard extension.
       - defaults: The user defaults instance to use, by default `.standard`.
     */
    func isKeyboardEnabled(
        withBundleId bundleId: String,
        defaults: UserDefaults = .standard
    ) -> Bool {
        enabledKeyboardBundleIds(defaults: defaults)
            .contains(bundleId)
    }
}

private class FullAccessInspector: UIInputViewController {}
#endif

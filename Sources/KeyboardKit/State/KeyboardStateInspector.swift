//
//  KeyboardStateInspector.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-05-05.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import Foundation
import UIKit

/**
 This protocol can be implemented by any type that can check
 state of any keyboard extension.

 This lets us check if a keyboard has been enabled in System
 Settings, if Full Access is granted, and if it's being used.

 This type supports bundle id wildcards, which means that it
 can be used to inspect multiple keyboards, with a single id.
 
 The easiest way to observe a keyboard's enabled state is to
 use the observable ``KeyboardStateContext`` class.
 */
public protocol KeyboardStateInspector {}

public extension KeyboardStateInspector {

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
     
     - Parameters:
       - bundleId: The bundle id of the keyboard extension.
     */
    func isKeyboardActive(
        withBundleId bundleId: String
    ) -> Bool {
        let ids = activeKeyboardBundleIds
        return isKeyboardActive(withId: bundleId, in: ids)
    }
    
    /**
     Whether or not a certain keyboard extension is enabled.

     - Parameters:
       - bundleId: The bundle id of the keyboard extension.
       - defaults: The user defaults instance to use, by default `.standard`.
     */
    func isKeyboardEnabled(
        withBundleId bundleId: String,
        defaults: UserDefaults = .standard
    ) -> Bool {
        let ids = enabledKeyboardBundleIds(defaults: defaults)
        return isKeyboardEnabled(withId: bundleId, in: ids)
    }
}


// MARK: - Internal Test Functions

extension KeyboardStateInspector {

    func isKeyboardActive(
        withId bundleId: String,
        in ids: [String]
    ) -> Bool {
        ids.first?.matchesBundleId(bundleId) ?? false
    }

    func isKeyboardEnabled(
        withId bundleId: String,
        in ids: [String]
    ) -> Bool {
        ids.contains { $0.matchesBundleId(bundleId) }
    }
}

extension String {

    func matchesBundleId(_ bundleId: String) -> Bool {
        if !bundleId.hasSuffix("*") { return self == bundleId }
        let wildcard = bundleId.replacingOccurrences(of: "*", with: "")
        return hasPrefix(wildcard)
    }
}

private class FullAccessInspector: UIInputViewController {}
#endif

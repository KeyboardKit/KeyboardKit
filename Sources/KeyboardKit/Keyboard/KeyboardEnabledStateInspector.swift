//
//  KeyboardEnabledStateInspector.swift
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
 state state of keyboard extensions.

 This type lets you check if a keyboard extension is enabled
 (in System Settings), if it is active (currently being used
 to type) and if it has been given full access.

 Note that you can use bundle id wildcards, which means that
 you can inspect multiple keyboards with a single id.
 
 The easiest way to observe a keyboard extension state is to
 use a ``KeyboardEnabledState`` which is an observable class
 that implements the protocol with published properties that
 let you easily observe any state changes.

 This protocol is implemented by the `UIInputViewController`
 base class in `UIKit`.
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

extension KeyboardEnabledStateInspector {

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

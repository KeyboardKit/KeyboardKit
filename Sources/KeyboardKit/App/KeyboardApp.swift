//
//  KeyboardApp.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-04-01.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

/// This type can be used to define important app properties,
/// and is also a namespace for KeyboardKit Pro app features.
///
/// You can create a static app value and add it to both the
/// main app target and its keyboard extension target, to be
/// able to easily refer to it from both targets:
///
/// ```swift
/// extension KeyboardApp {
///     static var keyboardKitDemo: Self {
///         .init(
///             name: "KeyboardKit",
///             licenseKey: "abc123",
///             bundleId: "com.keyboardkit.demo",
///             appGroupId: "group.com.keyboardkit.demo",
///             locales: [.english, .swedish, .persian],
///             dictationDeepLink: "keyboardkit://dictation"
///         )
///     }
/// }
/// ```
///
/// The app value can also resolve other properties that you
/// may need, such as a ``dictationConfiguration``.
///
/// > Important: The ``locales`` collection is only meant to
/// describe which locales you *want* to use in your app. It
/// will be capped to the number of locales your KeyboardKit
/// Pro license includes.
public struct KeyboardApp {

    /// Create a custom keyboard app value.
    ///
    /// - Parameters:
    ///   - name: The name of the app.
    ///   - licenseKey: Your license key, if any.
    ///   - bundleId: The app's bundle identifier.
    ///   - keyboardBundleId: The app's keyboard bundle identifier, by default `<bundleId>.keyboard`.
    ///   - appGroupId: The app's App Group identifier, if any.
    ///   - locales: The locales to use in the app, by default `.all`.
    ///   - dictationDeepLink: The app's dictation deep link, if any.
    public init(
        name: String,
        licenseKey: String? = nil,
        bundleId: String,
        keyboardBundleId: String? = nil,
        appGroupId: String? = "",
        locales: [KeyboardLocale] = .all,
        dictationDeepLink: String? = ""
    ) {
        self.name = name
        self.bundleId = bundleId
        self.appGroupId = appGroupId
        self.keyboardBundleId = keyboardBundleId ?? "\(bundleId).keyboard"
        self.locales = locales
        self.licenseKey = licenseKey
        if let appGroupId, let dictationDeepLink {
            dictationConfiguration = .init(
                appGroupId: appGroupId,
                appDeepLink: dictationDeepLink
            )
        } else {
            dictationConfiguration = nil
        }
    }

    /// The name of the app.
    public let name: String

    /// Your license key, if any.
    public let licenseKey: String?

    /// The app's bundle identifier.
    public let bundleId: String

    /// The app's keyboard bundle identifier
    public let keyboardBundleId: String

    /// The app's App Group identifier, if any.
    public let appGroupId: String?

    /// The locales to use in the app.
    public let locales: [KeyboardLocale]

    /// The app's dictation deep link, if any.
    public let dictationConfiguration: Dictation.KeyboardConfiguration?
}

public extension KeyboardApp {

    /// The keyboard extension bundle ID wildcard, which can
    /// be used to see if any keyboard extension in this app
    /// has been enabled.
    var keyboardExtensionBundleIdWildcard: String {
        "\(bundleId).*"
    }
}

private extension KeyboardApp {

    static var keyboardKitDemo: Self {
        .init(
            name: "KeyboardKit",
            licenseKey: "abc123",
            bundleId: "com.keyboardkit.demo",
            appGroupId: "group.com.keyboardkit.demo",
            locales: [.english, .swedish, .persian],
            dictationDeepLink: "keyboardkit://dictation"
        )
    }
}

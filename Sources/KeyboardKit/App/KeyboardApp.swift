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
/// You can create a static app value to then able to easily
/// refer to it from within your app:
///
/// ```swift
/// extension KeyboardApp {
///     static var keyboardKitDemo: Self {
///         .init(
///             icon: .keyboardKit,
///             bundleId: "com.keyboardkit.demo",
///             appGroupId: "group.com.keyboardkit.demo"
///         )
///     }
/// }
/// ```
public struct KeyboardApp {

    /// Create a custom keyboard app value.
    ///
    /// - Parameters:
    ///   - name: The name of the app.
    ///   - bundleId: The app's bundle identifier.
    ///   - appGroupId: The app's App Group identifier, if any.
    ///   - dictationDeepLink: The app's dictation deep link, if any.
    public init(
        name: String,
        bundleId: String,
        appGroupId: String? = "",
        dictationDeepLink: String? = ""
    ) {
        self.name = name
        self.bundleId = bundleId
        self.appGroupId = appGroupId
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

    /// The app's bundle identifier.
    public let bundleId: String

    /// The app's App Group identifier, if any.
    public let appGroupId: String?

    /// The app's dictation deep link, if any.
    public let dictationConfiguration: Dictation.KeyboardConfiguration?
}

private extension KeyboardApp {

    static var keyboardKitDemo: Self {
        .init(
            name: "KeyboardKit",
            bundleId: "com.keyboardkit.demo",
            appGroupId: "group.com.keyboardkit.demo",
            dictationDeepLink: "keyboardkit://dictation"
        )
    }
}

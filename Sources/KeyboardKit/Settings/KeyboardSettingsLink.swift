//
//  KeyboardSettingsLink.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-09.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This link can be used to navigate to System Settings.
///
/// The link's behavior can be a bit inconsistent. It should
/// always link to an app's settings in System Settings, but
/// can sometimes just link to the root. The reason for this
/// is currently unknown.
///
/// To improve the behavior of the link, simply add an empty
/// Settings Bundle to your app. This will make the app much
/// more likely to open the correct screen.
public struct KeyboardSettingsLink<Content: View>: View {

    /// Create a settings link with a custom label.
    ///
    /// - Parameters:
    ///   - url: The url to navigate to, by default ``Foundation/URL/keyboardSettings``.
    ///   - addNavigationArrow: Whether to add a trailing disclosure arrow, by default `false`.
    ///   - label: A label view builder.
    public init(
        url: URL? = .keyboardSettings,
        addNavigationArrow: Bool = false,
        @ViewBuilder label: @escaping () -> Content
    ) {
        self.url = url
        self.addNavigationArrow = addNavigationArrow
        self.label = label
    }

    private let url: URL?
    private let addNavigationArrow: Bool
    private let label: () -> Content

    public var body: some View {
        if let url = url {
            Link(destination: url) {
                bodyContent.contentShape(Rectangle())
            }
        }
    }
}

public extension KeyboardSettingsLink where Content == Label<Text, Image> {

    /// Create a settings link with a title and icon.
    ///
    /// - Parameters:
    ///   - title: The button text, by default `System Settings`.
    ///   - icon: The button icon, by default ``SwiftUI/Image/keyboardSettings``.
    ///   - url: The url to navigate to, by default ``Foundation/URL/keyboardSettings``.
    init(
        title: String = "System Settings",
        icon: Image = .keyboardSettings,
        url: URL? = .keyboardSettings
    ) {
        self.init(url: url) {
            Label {
                Text(title)
            } icon: {
                icon
            }
        }
    }
}

private extension KeyboardSettingsLink {

    @ViewBuilder
    var bodyContent: some View {
        if addNavigationArrow {
            HStack {
                label()
                Spacer()
                NavigationLinkArrow()
            }
        } else {
            label()
        }
    }
}

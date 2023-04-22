//
//  KeyboardSettingsLink.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-09.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This link can be used to navigate a user to System Settings.

 The link behavior is a bit inconsistent, where iOS can link
 to either application settings, or the System Settings root.
 */
public struct KeyboardSettingsLink<Content: View>: View {

    /**
     Create a keyboard settings link with a custom label.

     - Parameters:
       - url: The url to navigate to, by default `.keyboardSettings`.
       - addNavigationArrow: Whether or not to add a trailing navigation disclosure arrow, by default `false`.
       - label: The link label.
     */
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

    /**
     Create a keyboard settings link with a title and icon.

     - Parameters:
       - title: The button text, by default `System Settings`.
       - icon: The button icon, by default `.keyboardSettings`.
       - url: The url to navigate to, by default `.keyboardSettings`.
     */
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

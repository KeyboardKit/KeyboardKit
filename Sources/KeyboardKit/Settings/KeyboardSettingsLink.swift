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
public struct KeyboardSettingsLink: View {

    /**
     Create an enabled label.

     - Parameters:
       - title: The button text, by default `System Settings`.
       - icon: The button icon, by default `.keyboardSettings`.
       - url: The url to navigate to, by default `.keyboardSettings`.
     */
    public init(
        title: String = "System Settings",
        icon: Image = .keyboardSettings,
        url: URL? = .keyboardSettings
    ) {
        self.title = title
        self.icon = icon
        self.url = url
    }

    private let title: String
    private let icon: Image
    private let url: URL?

    public var body: some View {
        if let url = url {
            Link(destination: url) {
                Label {
                    Text(title)
                } icon: {
                    icon
                }
            }
        }
    }
}

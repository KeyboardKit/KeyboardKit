//
//  KeyboardSettings+Link.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-09.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

extension KeyboardSettings {
    
    /// This link can navigate to the app in System Settings.
    ///
    /// The link's behavior can be a bit inconsistent. While
    /// it *should* always navigate to the app, it sometimes
    /// just opens the System Settings root screen.
    ///
    /// The reason for this behavior is unknown, but you can
    /// improve the behavior by adding an Settings Bundle to
    /// your app. This will make it more likely for the link
    /// to behave as expected.
    ///
    /// You can customize the `url` if you want this link to
    /// open another screen.
    public struct Link<Content: View>: View {
        
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
            if let url {
                SwiftUI.Link(destination: url) {
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
        }
    }
}

public extension KeyboardSettings.Link where Content == Label<Text, Image> {

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

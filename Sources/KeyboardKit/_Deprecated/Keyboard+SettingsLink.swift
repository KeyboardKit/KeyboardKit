//
//  Keyboard+SettingsLink.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-09.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {
    
    @available(*, deprecated, message: "Use a regular SwiftUI Link with the .systemSettings URL instead.")
    struct SettingsLink<Content: View>: View {

        public init(
            url: URL? = .systemSettings,
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

@available(*, deprecated, message: "Use a regular SwiftUI Link with the .systemSettings URL instead.")
public extension Keyboard.SettingsLink where Content == Label<Text, Image> {

    /// Create a settings link with a title and icon.
    ///
    /// - Parameters:
    ///   - title: The button text, by default `System Settings`.
    ///   - icon: The button icon, by default ``SwiftUI/Image/keyboardSettings``.
    ///   - url: The url to navigate to, by default ``Foundation/URL/keyboardSettings``.
    ///   - addNavigationArrow: Whether to add a trailing disclosure arrow, by default `false`.   
    init(
        title: String = "System Settings",
        icon: Image = .keyboardSettings,
        url: URL? = .systemSettings,
        addNavigationArrow: Bool = false
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

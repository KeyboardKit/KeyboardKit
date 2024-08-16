//
//  KeyboardLocale+ListItem.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-08-16.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardLocale {

    /// This view can be used when listing a locale.
    struct ListItem: View {

        public init(
            locale: KeyboardLocale,
            displayLocale: Locale = .current,
            dragHandle: Bool = false,
            subtitle: String? = nil
        ) {
            self.locale = locale
            self.displayLocale = displayLocale
            self.dragHandle = dragHandle
            self.subtitle = subtitle
        }

        public init(
            locale: KeyboardLocale,
            displayLocale: KeyboardLocale,
            dragHandle: Bool = false,
            subtitle: String? = nil
        ) {
            self.init(
                locale: locale,
                displayLocale: displayLocale.locale,
                dragHandle: dragHandle,
                subtitle: subtitle
            )
        }

        private let locale: KeyboardLocale
        private let displayLocale: Locale
        private let dragHandle: Bool
        private let subtitle: String?

        public var body: some View {
            Label {
                HStack {
                    Text(locale.localizedName(in: displayLocale))
                    Spacer()
                    if dragHandle {
                        ListHandle()
                    } else if let subtitle {
                        Text(subtitle)
                            .foregroundColor(.secondary)
                    }
                }
            } icon: {
                Text(locale.flag)
            }
        }
    }


    /// This view can be used to reorder keyboard locales in
    /// a reorderable list.
    struct ListHandle: View {
        public var body: some View {
            Image(systemName: "line.3.horizontal")
                .font(Font.title2.weight(.light))
                .foregroundColor(.secondary)
                .opacity(0.5)
        }
    }
}

#Preview {
    
    List {
        KeyboardLocale.ListItem(locale: .swedish)
        KeyboardLocale.ListItem(locale: .danish, displayLocale: .german)
        KeyboardLocale.ListItem(locale: .danish, displayLocale: .german, dragHandle: false, subtitle: "foo")
        KeyboardLocale.ListItem(locale: .danish, displayLocale: .german, dragHandle: true, subtitle: "foo")
    }
}

//
//  KKL10n.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-25.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This enum defines localized keyboard texts.
///
/// You can use the ``text`` property to translate texts for
/// the current locale and ``text(forLocale:)`` to translate
/// text for a certain locale.
public enum KKL10n: String, CaseIterable, Identifiable {

    case `continue`
    case capsLock
    case done
    case emergencyCall
    case go
    case join
    case next
    case ok
    case `return`
    case route
    case search
    case searchEmoji
    case send
    case space
    case switcherAlphabetic
    case switcherNumeric
    case switcherSymbolic
}

public extension KKL10n {
    
    /// The item's unique identifier.
    var id: String { rawValue }
    
    /// The item's localization key.
    var key: String { rawValue }
    
    /// The item's localized text.
    var text: String {
        NSLocalizedString(key, bundle: .keyboardKit, comment: "")
    }

    /// Get the localized text for a certain `Locale`.
    func text(for locale: Locale) -> String {
        Self.text(forKey: key, locale: locale)
    }

    /// Get the localized text for a certain `Locale`.
    func text(forLocale locale: Locale) -> String {
        text(for: locale)
    }

    /// Get a localized text for a certain locale.
    static func text(forKey key: String, locale: Locale) -> String {
        guard let bundle = Bundle.keyboardKit.bundle(for: locale) else { return "" }
        return NSLocalizedString(key, bundle: bundle, comment: "")
    }
}

#Preview {
    
    NavigationView {
        List {
            ForEach(KKL10n.allCases) { item in
                VStack(alignment: .leading, spacing: 10) {
                    VStack(alignment: .leading) {
                        Text("default: \(item.text)")
                        Text("english: \(item.text(for: .english))")
                        Text("locale: \(item.text(for: .norwegian))")
                    }.font(.footnote)
                }.padding(.vertical, 4)
            }
        }.navigationTitle("Translations")
    }
}

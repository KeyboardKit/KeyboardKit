//
//  KKL10n.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-25.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This enum defines keyboard-specific, localized texts.
 
 Note that ``emergencyCall`` and ``ok`` are supported, since
 only `SubmitLabel` cases will be supported from now on. Any
 unsupported primary keys will get a fixed text.
 */
public enum KKL10n: String, CaseIterable, Identifiable {

    case `continue`
    case capsLock
    case done
    case emergencyCall  // deprecated
    case go
    case join
    case next
    case ok             // deprecated
    case `return`
    case route
    case search
    case send
    case space
    case switcherAlphabetic
    case switcherNumeric
    case switcherSymbolic
}



public extension KKL10n {

    /// The bundle to use to retrieve localized strings.
    static var bundle: Bundle = .keyboardKit
    
    @available(*, deprecated, renamed: "switcherAlphabetic")
    static var keyboardTypeAlphabetic = KKL10n.switcherAlphabetic
    @available(*, deprecated, renamed: "switcherNumeric")
    static var keyboardTypeNumeric = KKL10n.switcherNumeric
    @available(*, deprecated, renamed: "switcherSymbolic")
    static var keyboardTypeSymbolic = KKL10n.switcherSymbolic
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
    
    /// Get the localized text for a certain context.
    func text(for context: KeyboardContext) -> String {
        text(for: context.locale)
    }
    
    /// Get the localized text for a certain locale.
    func text(for locale: KeyboardLocale) -> String {
        text(for: locale.locale)
    }

    /// Get the localized text for a certain `Locale`.
    func text(for locale: Locale) -> String {
        Self.text(forKey: key, locale: locale)
    }

    /// Get a localized text for a certain locale.
    static func text(forKey key: String, locale: KeyboardLocale) -> String {
        text(forKey: key, locale: locale.locale)
    }

    /// Get a localized text for a certain locale.
    static func text(forKey key: String, locale: Locale) -> String {
        guard let bundle = Bundle.keyboardKit.bundle(for: locale) else { return "" }
        return NSLocalizedString(key, bundle: bundle, comment: "")
    }
}

struct KKL10n_Previews: PreviewProvider {
    
    static let context: KeyboardContext = {
        let context = KeyboardContext.preview
        context.locale = KeyboardLocale.norwegian.locale
        return context
    }()
    
    static var previews: some View {
        NavigationView {
            List {
                ForEach(KKL10n.allCases) { item in
                    VStack(alignment: .leading, spacing: 10) {
                        VStack(alignment: .leading) {
                            Text("default: \(item.text)")
                            Text("context: \(item.text(for: context))")
                        }.font(.footnote)
                    }.padding(.vertical, 4)
                }
            }.navigationTitle("Translations")
        }
    }
}

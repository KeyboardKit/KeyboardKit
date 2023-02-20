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
 */
public enum KKL10n: String, CaseIterable, Identifiable {

    case
    done,
    go,
    join,
    ok,
    `return`,
    search,
    space,
    
    keyboardTypeAlphabetic,
    keyboardTypeNumeric,
    keyboardTypeSymbolic,

    searchEmoji
}

public extension KKL10n {

    /**
     The bundle to use to retrieve localized strings.

     You should only override this value when the entire set
     of localized texts should be loaded from another bundle.
     */
    static var bundle: Bundle = .keyboardKit
}

public extension KKL10n {
    
    /**
     The item's unique identifier.
     */
    var id: String { rawValue }
    
    /**
     The item's localization key.
     */
    var key: String { rawValue }
    
    /**
     The item's localized text.
     */
    var text: String {
        NSLocalizedString(key, bundle: .keyboardKit, comment: "")
    }
    
    /**
     Get the localized text for a certain ``KeyboardContext``.
     */
    func text(for context: KeyboardContext) -> String {
        text(for: context.locale)
    }
    
    /**
     Get the localized text for a certain ``KeyboardLocale``.
     */
    func text(for locale: KeyboardLocale) -> String {
        text(for: locale.locale)
    }

    /**
     Get the localized text for a certain `Locale`.
     */
    func text(for locale: Locale) -> String {
        Self.text(forKey: key, locale: locale)
    }

    /**
     Get a localized text for a certain ``KeyboardLocale``.
     */
    static func text(forKey key: String, locale: KeyboardLocale) -> String {
        text(forKey: key, locale: locale.locale)
    }

    /**
     Get a localized text for a certain `Locale`.
     */
    static func text(forKey key: String, locale: Locale) -> String {
        guard let bundle = Bundle.keyboardKit.bundle(for: locale) else { return "" }
        return NSLocalizedString(key, bundle: bundle, comment: "")
    }
}

struct KKL10n_Previews: PreviewProvider {
    
    static let context: KeyboardContext = {
        let context = KeyboardContext.preview
        context.locale = KeyboardLocale.swedish.locale
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
                            Divider()
                            ForEach(KeyboardLocale.allCases) {
                                Text("\($0.id): \(item.text(for: $0))")
                            }
                        }.font(.footnote)
                    }.padding(.vertical, 4)
                }
            }.navigationTitle("Translations")
        }
    }
}

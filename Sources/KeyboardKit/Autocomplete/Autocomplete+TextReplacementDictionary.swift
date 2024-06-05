//
//  Autocomplete+TextReplacementDictionary.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-06-05.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Autocomplete {

    /// This type can be used to define text replacements to
    /// e.g. define custom autocorrections.
    struct TextReplacementDictionary {

        public init(_ initialValue: KeyboardLocale.Dictionary<[String: String]> = .init()) {
            self.dictionary = initialValue
        }

        private var dictionary: KeyboardLocale.Dictionary<[String: String]> = .init()
    }
}

public extension Autocomplete.TextReplacementDictionary {

    /// This predefined dictionary can be used as a starting
    /// point when defining a custom list of autocorrections.
    static var additionalAutocorrections: Self {
        .init(.init(
            [
                KeyboardLocale.english: [
                    "ill": "I'll",
                    "Ill": "I'll"
                ]
            ]
        ))
    }
}

public extension Autocomplete.TextReplacementDictionary {

    /// Insert a word replacement for a certain locale.
    mutating func addWordReplacement(
        _ replacement: String,
        for word: String,
        locale: KeyboardLocale
    ) {
        addWordReplacements([word: replacement], for: locale)
    }

    /// Insert a word replacement for a certain locale.
    mutating func addWordReplacements(
        _ dict: [String: String],
        for locale: KeyboardLocale
    ) {
        var val = dictionary.value(for: locale) ?? [:]
        dict.forEach {
            val[$0.key] = $0.value
        }
        setWordReplacements(val, for: locale)
    }

    /// Set word replacement for a certain locale.
    mutating func setWordReplacements(
        _ dict: [String: String],
        for locale: KeyboardLocale
    ) {
        dictionary.set(dict, for: locale)
    }

    /// Set word replacement for a certain locale.
    func wordReplacement(
        for word: String,
        locale: KeyboardLocale
    ) -> String? {
        wordReplacements(for: locale)?[word]
    }

    /// Get word replacement for a certain locale.
    func wordReplacements(
        for locale: KeyboardLocale
    ) -> [String: String]? {
        dictionary.value(for: locale)
    }
}

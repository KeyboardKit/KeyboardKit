//
//  Autocomplete+TextReplacementDictionary.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-06-05.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Autocomplete {

    /// This dictionary can be used to define localized text
    /// replacements, for instance custom autocorrections.
    struct TextReplacementDictionary {

        public init(
            _ initialValue: Dictionary = .init()
        ) {
            self.dictionary = initialValue
        }

        public typealias Dictionary = Locale.Dictionary<[String: String]>

        private var dictionary: Dictionary = .init()
    }
}

public extension Autocomplete.TextReplacementDictionary {

    /// This predefined dictionary can be used as a starting
    /// point when defining a custom list of autocorrections.
    static var additionalAutocorrections: Self {
        .init(.init(
            [
                Locale.english: [
                    "i": "I",
                    "ill": "I'll",
                    "Ill": "I'll"
                ]
            ]
        ))
    }
}

public extension Autocomplete.TextReplacementDictionary {

    /// Insert a text replacement for a certain locale.
    mutating func addTextReplacement(
        for text: String,
        with replacement: String,
        locale: Locale
    ) {
        addTextReplacements([text: replacement], for: locale)
    }

    /// Insert a text replacement for a certain locale.
    mutating func addTextReplacements(
        _ dict: [String: String],
        for locale: Locale
    ) {
        var val = dictionary.value(for: locale) ?? [:]
        dict.forEach {
            val[$0.key] = $0.value
        }
        setTextReplacements(val, for: locale)
    }

    /// Set the text replacements for a certain locale.
    mutating func setTextReplacements(
        _ dict: [String: String],
        for locale: Locale
    ) {
        dictionary.set(dict, for: locale)
    }

    /// Get a text replacement for a certain text and locale.
    func textReplacement(
        for text: String,
        locale: Locale
    ) -> String? {
        textReplacements(for: locale)?[text]
    }

    /// Get all text replacements for a certain locale.
    func textReplacements(
        for locale: Locale
    ) -> [String: String]? {
        dictionary.value(for: locale)
    }
}

//
//  KeyboardCallout+Actions.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardCallout {

    /// This type can be used to define callout actions that
    /// can be shown in an ``KeyboardCallout/ActionCallout``.
    ///
    /// You can use standard, ``english`` callout actions or
    /// upgrade to KeyboardKit Pro to unlock callout actions
    /// for all supported locales.
    ///
    /// You can customize the callout actions for any action
    /// with ``SwiftUICore/View/keyboardCalloutActions(_:)``.
    struct Actions: KeyboardModel {

        /// Create custom actions from an action dictionary.
        ///
        /// While the character-based initializer maps every
        /// value to both lower and uppercase variants, this
        /// initializer just applies the provided actions as
        /// they are, without any modifications.
        public init(
            actions: [KeyboardAction: [KeyboardAction]]
        ) {
            self.actionsDictionary = actions
        }

        /// Create custom actions from a string dictionary.
        ///
        /// This initializer expects an action/actions array
        /// that will be mapped to ``KeyboardAction`` values
        /// with both the lower and uppercase variants.
        public init(
            characters: [String: String]
        ) {
            let lowerChars = characters.mapKeys { $0.lowercased() }
                .mapValues { $0.map { String($0).lowercased() } }
            let upperChars = characters.mapKeys { $0.uppercased() }
                .mapValues { $0.map { String($0).uppercased() } }
            let lowerActions = lowerChars.mapKeys { KeyboardAction.character($0) }
                .mapValues { $0.map { KeyboardAction.character($0) } }
            let upperActions = upperChars.mapKeys { KeyboardAction.character($0) }
                .mapValues { $0.map { KeyboardAction.character($0) } }
            let actions = lowerActions.merging(upperActions) { _, new in new }
            self.init(actions: actions)
        }

        /// An action mapping dictionary.
        public var actionsDictionary: [KeyboardAction: [KeyboardAction]]

        /// Whether diacritic key match is enabled.
        public var isDiacriticInsensitive = false
    }
}

private extension Dictionary {

    func mapKeys<T>(_ transform: (Key) -> T) -> [T: Value] {
        Dictionary<T, Value>(map { (transform($0.key), $0.value) },
                             uniquingKeysWith: { first, _ in first })
    }

    func mapValues<T>(_ transform: (Value) -> T) -> [Key: T] {
        Dictionary<Key, T>(map { ($0.key, transform($0.value)) },
                           uniquingKeysWith: { first, _ in first })
    }
}

public extension KeyboardCallout.Actions {

    /// Base callout actions, without any alphabetic actions.
    static let base = Self.init(
        characters: Self.baseNumericAndSymbolicChars
    )

    /// Base numeric and symbolic callout actions characters.
    static var baseNumericAndSymbolicChars: [String: String] {
        [
            "0": "0°",

            "$": "$€£¥₩₽¢",
            "₱": "₱$€£¥₽",
            "₽": "₽$¥€¢£₩",
            "¥": "¥$₽€¢£₩",
            "€": "€$£₽¥¢₩",
            "¢": "¢$₽¥€£₩",
            "£": "£€$₽¥¢₩",
            "₩": "₩$₽¥€¢£",
            "₾": "₾$€£¥",
            "₴": "₴₽₩£$€¥",
            "₫": "₫$€£¥₩₽¢",

            "-": "-–—•",
            "/": "/\\",
            "&": "&§",
            "”": "\"„“”«»",
            ".": ".…",
            "?": "?¿",
            "!": "!¡",
            "’": "'’‘`",

            "%": "%‰",
            "=": "=≠≈"
        ]
    }

    /// English callout actions.
    static let english: Self = {
        let alpha = Self.englishAlphabeticCharacters
        let numerics = Self.baseNumericAndSymbolicChars
        let merged = alpha.merging(numerics) { (_, new) in new }
        return Self.init(characters: merged)
    }()

    /// English, alphabetic callout actions characters.
    static var englishAlphabeticCharacters: [String: String] = {
        [
            "a": "aàáâäǎæãåāăą",
            "c": "cçćčċ",
            "d": "dďð",
            "e": "eèéêëēėę",
            "g": "gğġ",
            "h": "hħ",
            "i": "iîìíïǐĩī",
            "k": "kķ",
            "l": "lłļľ",
            "n": "nñńņň",
            "o": "oòóôöǒœøõōő",
            "r": "rř",
            "s": "sßśšŝṣș",
            "t": "tțťþ",
            "u": "uǔûùúüũūu",
            "w": "wŵ",
            "y": "yýŷÿ",
            "z": "zźžż"
        ]
    }()
}

public extension KeyboardCallout.Actions {

    /// Get keyboard callout actions for the provided action.
    func actions(
        for action: KeyboardAction
    ) -> [KeyboardAction]? {
        if let result = actionsDictionary[action] { return result }
        guard isDiacriticInsensitive else { return nil }
        return diacriticInsensitiveActions(for: action)
    }
}

private extension KeyboardCallout.Actions {

    /// Perform a diacritic insensitive dictionary key match
    /// by iterating over all the keys in the dictionary. It
    /// is a slow method that is needed for some RTL locales.
    func diacriticInsensitiveActions(
        for action: KeyboardAction
    ) -> [KeyboardAction]? {
        guard case .character(let actionChar) = action else { return nil }
        return actionsDictionary.keys.compactMap {
            if case .character(let char) = $0 { return char }
            return nil
        }
        .first { $0.compare(actionChar, options: .diacriticInsensitive) == .orderedSame }
        .flatMap { actionsDictionary[.character($0)] }
    }
}

public extension KeyboardCallout {

    /// This type is used to customize callout actions using
    /// ``SwiftUICore/View/keyboardCalloutActions(_:)``.
    typealias ActionsBuilder = (ActionsBuilderParams) -> [KeyboardAction]?

    /// This type is used to customize callout actions using
    /// ``SwiftUICore/View/keyboardCalloutActions(_:)``.
    struct ActionsBuilderParams: KeyboardModel {

        /// Create a callout actions builder parameter value.
        public init(
            action: KeyboardAction,
        ) {
            self.action = action
        }

        /// The action to get callout actions for.
        public let action: KeyboardAction
    }
}

public extension EnvironmentValues {

    /// This value can be used to set custom callout actions.
    ///
    /// > Note: The builder returns `nil` by default to make
    /// it possible to check if there is an injected builder.
    /// If not, the legacy service is used. The builder will
    /// replace the service in the next major version, after
    /// which this should return the standard value.
    @Entry var keyboardCalloutActions: KeyboardCallout.ActionsBuilder = { _ in nil }
}

public extension View {

    /// This view modifier can be used to set custom callout
    /// actions to show when long pressing a key.
    ///
    /// You can customize callouts for any actions, then use
    /// ``KeyboardCallout/ActionsParams/standardActions(for:)``
    /// to return the standard actions for all other actions.
    func keyboardCalloutActions(
        _ builder: @escaping KeyboardCallout.ActionsBuilder
    ) -> some View {
        self.environment(\.keyboardCalloutActions, builder)
    }
}

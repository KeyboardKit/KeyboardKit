//
//  KeyboardAction+PrimaryType.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-06-23.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardAction {

    /**
     This enum can be used together with ``primary(_:)``.

     Primary buttons are color accented buttons that trigger
     a submit action in the keyboard, just like ``return``.
     */
    enum PrimaryType: CaseIterable, Codable, Equatable, Identifiable {

        /// A return key that uses a return text and not an ⏎ icon.
        case `return`

        /// A done key used in e.g. Calendar add location.
        case done

        /// A go key used in e.g. the Safari address bar.
        case go

        /// A join key used when e.g. joining a wifi network.
        case join

        /// A new line key used to force using a line arrow.
        case newLine

        /// An ok key, which isn't actually used in native.
        case ok

        /// A "search" key used in e.g. web search.
        case search

        /// A custom key with a custom title.
        case custom(title: String)

        /**
         All unique primary keyboard action types, excluding
         ``KeyboardAction/custom(named:)``.
         */
        public static var allCases: [KeyboardAction.PrimaryType] {
            return [.return, .done, .go, .join, .newLine, .ok, .search]
        }
    }
}

public extension KeyboardAction.PrimaryType {


    /**
     The type's unique identifier.
     */
    var id: String {
        switch self {
        case .return: return "return"
        case .done: return "done"
        case .go: return "go"
        case .join: return "join"
        case .newLine: return "newLine"
        case .ok: return "ok"
        case .search: return "search"
        case .custom(let title): return title
        }
    }

    /**
     Whether or not the action is a system action.

     A system action is by default rendered as a dark button.
     */
    var isSystemAction: Bool {
        switch self {
        case .return: return true
        case .done: return false
        case .go: return false
        case .join: return false
        case .newLine: return true
        case .ok: return false
        case .search: return false
        case .custom: return false
        }
    }

    /**
     The standard button to image for a certain locale.
     */
    func standardButtonImage(for locale: Locale) -> Image? {
        switch self {
        case .newLine: return .keyboardNewline(for: locale)
        default: return nil
        }
    }

    /**
     The standard button to text for a certain locale.
     */
    func standardButtonText(for locale: Locale) -> String? {
        switch self {
        case .custom(let title): return title
        case .done: return KKL10n.done.text(for: locale)
        case .go: return KKL10n.go.text(for: locale)
        case .join: return KKL10n.join.text(for: locale)
        case .newLine: return nil
        case .return: return KKL10n.return.text(for: locale)
        case .ok: return KKL10n.ok.text(for: locale)
        case .search: return KKL10n.search.text(for: locale)
        }
    }
}

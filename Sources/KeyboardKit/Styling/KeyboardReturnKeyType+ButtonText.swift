//
//  KeyboardAction+ButtonImage.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-04-17.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Keyboard.ReturnKeyType {

    /// The standard button to text for a certain locale.
    func standardButtonText(for locale: Locale) -> String? {
        switch self {
        case .custom(let title): title
        case .continue: KKL10n.continue.text(for: locale)
        case .done: KKL10n.done.text(for: locale)
        case .emergencyCall: KKL10n.emergencyCall.text(for: locale)
        case .go: KKL10n.go.text(for: locale)
        case .join: KKL10n.join.text(for: locale)
        case .newLine: nil
        case .next: KKL10n.next.text(for: locale)
        case .return: KKL10n.return.text(for: locale)
        case .route: KKL10n.route.text(for: locale)
        case .ok: KKL10n.ok.text(for: locale)
        case .search: KKL10n.search.text(for: locale)
        case .send: KKL10n.send.text(for: locale)
        }
    }
}

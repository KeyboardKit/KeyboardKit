//
//  EmojiKit+KeyboardKit.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-10-07.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Localizable {

    /// The localized name for a certain locale.
    ///
    /// - Parameters:
    ///   - locale: The locale to use, by default `.current`.
    func localizedName(
        in locale: Locale = .current
    ) -> String {
        localizedName(in: locale, bundle: .keyboardKit)
    }
}

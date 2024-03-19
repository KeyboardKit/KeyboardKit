//
//  EmojiCategory+Localization.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2022-12-12.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import Foundation

extension EmojiCategory: Localizable {
    
    /// The `Localizable.strings` key to use when localizing.
    public var localizationKey: String {
        "EmojiCategory.\(id)"
    }
}

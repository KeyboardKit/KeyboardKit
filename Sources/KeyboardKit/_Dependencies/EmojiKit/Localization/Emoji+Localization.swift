//
//  Emoji+Localization.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2022-12-12.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import Foundation

extension Emoji: Localizable {
    
    /// The `Localizable.strings` key to use when localizing.
    public var localizationKey: String {
        char
    }
}

//
//  Emoji+Localization.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-12-12.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Emoji {

    /**
     Get the key that is to be added to `Localizable.strings`
     to localize the emoji.
     */
    var localizedName: String {
        let localized = NSLocalizedString(localizationKey, comment: "Emoji's localized name")
        let hasLocalizedName = localized != localizationKey
        let result = hasLocalizedName ? localized : (unicodeName ?? "")
        return result.trimmed()
    }

    /**
     Get the key that is to be added to `Localizable.strings`
     to localize the emoji.
     */
    var localizationKey: String {
        "Emoji.\(localizationKeyId ?? "")"
    }

    /**
     Get the key that is to be added to `Localizable.strings`
     to localize the emoji.
     */
    var localizationKeyId: String? {
        unicodeName?.replacingOccurrences(of: " ", with: "")
    }
}

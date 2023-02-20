//
//  Locale+Localized.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-04.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Locale {
    
    /**
     The localized name of the locale's identifier.
     */
    var localizedName: String {
        let text = localizedString(forIdentifier: identifier) ?? "-"
        return text.capitalized
    }
    
    /**
     The localized name of the locale's language code.
     */
    var localizedLanguageName: String? {
        guard let code = languageCode else { return nil }
        return localizedString(forLanguageCode: code)
    }
}

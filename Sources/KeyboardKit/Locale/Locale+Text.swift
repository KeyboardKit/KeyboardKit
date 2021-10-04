//
//  Locale+Text.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-04.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Locale {
    
    /**
     The localized language name of the locale.
     */
    var localizedLanguageName: String? {
        guard let code = languageCode else { return nil }
        return localizedString(forLanguageCode: code)
    }
}

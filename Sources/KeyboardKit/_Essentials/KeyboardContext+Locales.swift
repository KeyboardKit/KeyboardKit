//
//  KeyboardContext+Locale.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardContext {

    
}

extension KeyboardContext {

    /// This is internal until we find a better name for it.
    var selectableLocales: [Locale] {
        let addedLocales = settings.addedLocales
        return addedLocales.isEmpty ? locales : addedLocales
    }
}

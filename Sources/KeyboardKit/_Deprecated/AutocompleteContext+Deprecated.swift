//
//  AutocompleteContext+Deprecated.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-12-06.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension AutocompleteContext {
    
    @available(*, deprecated, renamed: "isAutocompleteEnabled")
    var isEnabled: Bool {
        isAutocompleteEnabled
    }
}

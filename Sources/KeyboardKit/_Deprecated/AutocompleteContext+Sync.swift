//
//  AutocompleteContext+Sync.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-06-04.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

public extension AutocompleteContext {

    /// DEPRECATED!
    ///
    /// > Warning: Settings has been moved to ``AutocompleteContext``. This function will be removed in KeyboardKit 9.0.
    func sync(with settings: AutocompleteSettings) {
        DispatchQueue.main.async {
            self.syncAfterAsync(with: settings)
        }
    }
}

extension AutocompleteContext {

    /// Perform a settings sync after an async delay.
    func syncAfterAsync(with settings: AutocompleteSettings) {
        if suggestionsDisplayCount != settings.suggestionsDisplayCount {
            suggestionsDisplayCount = settings.suggestionsDisplayCount
        }
        if isAutocompleteEnabled != settings.isAutocompleteEnabled {
            isAutocompleteEnabled = settings.isAutocompleteEnabled
        }
        if isAutocorrectEnabled != settings.isAutocorrectEnabled {
            isAutocorrectEnabled = settings.isAutocorrectEnabled
        }
    }
}

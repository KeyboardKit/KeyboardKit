//
//  AutocompleteSettings.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-06-02.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This observable class can be used to manage settings for
/// the ``Autocomplete`` namespace.
public class AutocompleteSettings: ObservableObject {

    static let prefix = KeyboardSettings.storeKeyPrefix(for: "autocomplete")

    @AppStorage("\(prefix)autocompleteSuggestionCount", store: .keyboardSettings)
    var autocompleteSuggestionCount = 3

    @AppStorage("\(prefix)isAutocompleteEnabled", store: .keyboardSettings)
    var isAutocompleteEnabled = true

    @AppStorage("\(prefix)isAutocorrectEnabled", store: .keyboardSettings)
    var isAutocorrectEnabled = true
}

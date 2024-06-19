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

    @AppStorage("\(prefix)isAutocompleteEnabled", store: .keyboardSettings)
    public var isAutocompleteEnabled = true {
        didSet { triggerChange() }
    }

    @AppStorage("\(prefix)isAutocorrectEnabled", store: .keyboardSettings)
    public var isAutocorrectEnabled = true {
        didSet { triggerChange() }
    }

    @AppStorage("\(prefix)suggestionsDisplayCount", store: .keyboardSettings)
    public var suggestionsDisplayCount = 3 {
        didSet { triggerChange() }
    }

    @Published
    var lastChanged = Date()
}

private extension AutocompleteSettings {

    func triggerChange() {
        lastChanged = Date()
    }
}

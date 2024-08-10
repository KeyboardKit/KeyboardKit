//
//  AutocompleteSettings.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-06-02.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// DEPRECATED!
///
/// > Warning: Settings are moved to ``AutocompleteContext``.
/// This type will be removed in KeyboardKit 9.0.
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

    @AppStorage("\(prefix)lastSynced", store: .keyboardSettings)
    var lastSynced = Keyboard.StorageValue(Date())
}

private extension AutocompleteSettings {

    func triggerChange() {
        lastChanged = Date()
    }
}

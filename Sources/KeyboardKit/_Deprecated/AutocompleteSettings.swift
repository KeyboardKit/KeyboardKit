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
/// > Warning: Settings have been moved to the context. This
/// type will be removed in KeyboardKit 9.0.
public class AutocompleteSettings: ObservableObject, LegacySettings {

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

extension AutocompleteSettings {

    func syncToContextIfNeeded(
        _ context: AutocompleteContext
    ) {
        guard shouldSyncToContext else { return }
        context.sync(with: self)
        updateLastSynced()
    }
}

protocol LegacySettings: AnyObject {

    static var prefix: String { get }

    var lastChanged: Date { get set }
}

extension LegacySettings {

    var legacySettingsStore: UserDefaults {
        KeyboardSettings.store
    }

    var lastChangedKey: String { "\(Self.prefix)legacySettingsLastChanged" }

    var lastChangedValue: TimeInterval {
        get { KeyboardSettings.store.double(forKey: lastChangedKey) }
        set { KeyboardSettings.store.set(newValue, forKey: lastChangedKey) }
    }

    var lastSyncedKey: String { "\(Self.prefix)legacySettingsLastSynced" }

    var lastSyncedValue: TimeInterval {
        get { KeyboardSettings.store.double(forKey: lastSyncedKey) - 1 }
        set { KeyboardSettings.store.set(newValue, forKey: lastSyncedKey) }
    }

    var shouldSyncToContext: Bool {
        lastSyncedValue < lastChangedValue
    }

    func triggerChange() {
        lastChanged = Date()
        lastChangedValue = Date().timeIntervalSince1970
        UserDefaults.keyboardSettings.synchronize()
    }

    func updateLastSynced() {
        lastSyncedValue = Date().timeIntervalSince1970
        UserDefaults.keyboardSettings.synchronize()
    }
}

//
//  PersistedKeyboardSetting+Identifiable.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-09.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation

public extension PersistedKeyboardSetting {
    
    init<Context: Identifiable>(
        _ setting: KeyboardSetting,
        context: Context,
        default defaultValue: Value,
        userDefaults: UserDefaults = .standard) {
        self.init(
            key: setting.key(for: context),
            default: defaultValue,
            userDefaults: userDefaults
        )
    }
}

//
//  DictationSettings.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-06-02.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This observable class can be used to manage settings for
/// the ``Dictation`` namespace.
public class DictationSettings: ObservableObject {

    static let prefix = KeyboardSettings.storeKeyPrefix(for: "dictation")

    @AppStorage("\(prefix)silenceLimit", store: .keyboardSettings)
    public var silenceLimit = 5.0 {
        didSet { triggerChange() }
    }

    @Published
    var lastChanged = Date()
}

private extension DictationSettings {

    func triggerChange() {
        lastChanged = Date()
    }
}

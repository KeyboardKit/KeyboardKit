//
//  DictationContext+Sync.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-06-04.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

public extension DictationContext {

    /// Sync the context with the provided settings.
    func sync(with settings: DictationSettings) {
        DispatchQueue.main.async {
            self.syncAfterAsync(with: settings)
        }
    }
}

extension DictationContext {

    /// Perform a settings sync after an async delay.
    func syncAfterAsync(with settings: DictationSettings) {
        if silenceLimit != settings.silenceLimit {
            silenceLimit = settings.silenceLimit
        }
    }
}

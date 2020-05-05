//
//  Global+IsKeyboardEnabled.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-19.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation

@available(*, deprecated, message: "Implement `KeyboardStateInspector` instead.")
public func isKeyboardEnabled(
    _ bundleId: String,
    defaults: UserDefaults = .standard) -> Bool {
    BridgingClass().isKeyboardEnabled(bundleId, defaults: defaults)
}

private class BridgingClass: KeyboardStateInspector {}

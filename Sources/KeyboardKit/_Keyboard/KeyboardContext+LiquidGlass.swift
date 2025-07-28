//
//  KeyboardContext+LiquidGlass.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-07-27.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

private extension KeyboardContext {

    var defaults: UserDefaults { .keyboardSettings }

    var isLiquidGlassEnabledKey: String {
        "com.keyboardkit.settings.keyboard.isLiquidGlassEnabled"
    }
}

public extension KeyboardContext {

    /// Enables or disables Liquid Glass.
    ///
    /// > Important: This must be manually handled in 9.9 to
    /// avoid requiring Xcode 26. Make an availability check
    /// in your controller and enable Liquid Glass if iOS 26
    /// is available.
    var isLiquidGlassEnabled: Bool {
        get { defaults.bool(forKey: isLiquidGlassEnabledKey) }
        set { defaults.set(newValue, forKey: isLiquidGlassEnabledKey) }
    }

    /// Enables or disables Liquid Glass.
    ///
    /// > Important: This must be manually handled in 9.9 to
    /// avoid requiring Xcode 26. Make an availability check
    /// in your controller and enable Liquid Glass if iOS 26
    /// is available.
    func setIsLiquidGlassEnabled(_ enabled: Bool) {
        isLiquidGlassEnabled = enabled
    }
}

#Preview {

    Image("iPhone", bundle: .module)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .ignoresSafeArea(.all)
}

//
//  DemoCalloutService.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

#if IS_KEYBOARDKIT
import KeyboardKit
#elseif IS_KEYBOARDKITPRO
import KeyboardKitPro
#endif

/// This demo-specific callout service shows "keyboard" when
/// a "k" key is long pressed. 
class DemoCalloutService: Callouts.BaseService {

    override func calloutActionString(for char: String) -> String {
        switch char {
        case "k": String("keyboard".reversed())
        default: super.calloutActionString(for: char)
        }
    }
}

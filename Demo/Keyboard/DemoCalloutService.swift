//
//  DemoCalloutService.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import UIKit

/// This demo-specific callout service modifies some callout
/// actions, to show "keyboard" actions for the "k" key.
///
/// You can play around with the class and customize it more,
/// to see how it affects the demo keyboard.
///
/// The ``KeyboardViewController`` shows how you can replace
/// the standard provider with this custom one. 
class DemoCalloutService: Callouts.BaseService {

    override func calloutActionString(for char: String) -> String {
        switch char {
        case "k": String("keyboard".reversed())
        default: super.calloutActionString(for: char)
        }
    }
}

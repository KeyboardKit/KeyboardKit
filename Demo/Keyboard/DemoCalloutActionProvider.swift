//
//  DemoCalloutActionProvider.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import UIKit

/// This demo-specific class inherits the standard one, then
/// overrides it with demo-specific adjustments.
///
/// You can play around with this class to see how it can be
/// customized, tro trigger custom actions.
class DemoCalloutActionProvider: BaseCalloutActionProvider {
    
    override func calloutActionString(for char: String) -> String {
        switch char {
        case "k": String("keyboard".reversed())
        default: super.calloutActionString(for: char)
        }
    }
}

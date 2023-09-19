//
//  DemoCalloutActionProvider.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import UIKit

/**
 This demo-specific callout action provider adds a couple of
 dummy callouts when typing.
 */
class DemoCalloutActionProvider: BaseCalloutActionProvider {

    override func calloutActionString(for char: String) -> String {
        switch char {
        case "a": return "aàáâäæãåā"
        case "c": return "cçćč"
        case "e": return "eèéêëēėę"
        default: return ""
        }
    }
}

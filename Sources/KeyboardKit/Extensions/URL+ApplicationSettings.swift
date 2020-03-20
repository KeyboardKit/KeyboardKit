//
//  URL+KeyboardSettings.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-19.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation
import UIKit

public extension URL {
    
    /**
     The `URL` to the system keyboard settings. You can open
     it from the hosting app with `UIApplication`s `openUrl`
     functionality.
     */
    static var keyboardSettings: URL? {
        URL(string: "App-Prefs:root=General&path=Keyboard")
    }
}

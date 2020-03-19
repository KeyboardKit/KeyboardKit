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
     The `URL` to the application's system settings. You can
     open it from e.g. the hosting app, using `UIApplication`.
     */
    static var keyboardSettings: URL? {
        URL(string: UIApplication.openSettingsURLString)
    }
}

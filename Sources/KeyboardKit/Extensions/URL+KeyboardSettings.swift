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
     The `URL` to the app's settings screen, if any.
     
     If the app has no custom settings screen, this url will
     open the main system settings screen.
     */
    static var keyboardSettings: URL? {
        URL(string: UIApplication.openSettingsURLString)
    }
}

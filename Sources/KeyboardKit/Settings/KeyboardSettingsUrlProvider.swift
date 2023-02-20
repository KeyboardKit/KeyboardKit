//
//  KeyboardSettingsUrlProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-19.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import Foundation

#if os(iOS) || os(tvOS)
import UIKit
#endif

/**
 This protocol can be implemented by any type that should be
 able to resolve a URL to an app's keyboard settings page in
 System Settings.

 This protocol is implemented by `URL`.
 */
public protocol KeyboardSettingsUrlProvider {}

public extension KeyboardSettingsUrlProvider {

    /**
     The url to the app's settings screen in System Settings.

     If the app has no custom settings screen, this url will
     open the main system settings screen.
     */
    static var keyboardSettings: URL? {
        #if os(iOS) || os(tvOS)
        URL(string: UIApplication.openSettingsURLString)
        #else
        nil
        #endif
    }
}

extension URL: KeyboardSettingsUrlProvider {}

//
//  Url+KeyboardSettings.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-19.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import Foundation

#if os(iOS) || os(tvOS)
import UIKit
#endif

public extension URL {
    
    /**
     Use this URL to deep link to your app's custom settings
     in System Settings.
     
     The URL behavior is inconsistent. It should always link
     to an app's custom settings in System Settings, but can
     sometimes just link to the System Settings root instead.
     The reason for this behavior is unknown.
     
     To improve the behavior of this link, just add an empty
     Settings Bundle to your application bundle. This causes
     your app to more consistently open the correct screen.
     
     Maybe `appSettings` would be a better name for this URL,
     but this name was selected to reduce the risk of naming
     conflicts with other URL extensions.
     */
    static var keyboardSettings: URL? {
        #if os(iOS) || os(tvOS)
        URL(string: UIApplication.openSettingsURLString)
        #else
        nil
        #endif
    }
}

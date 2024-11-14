//
//  Url+SystemSettings.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-19.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

#if os(iOS) || os(tvOS) || os(visionOS)
import UIKit
#endif

public extension URL {
    
    /// This URL will deep link to the app's custom settings
    /// in System Settings.
    ///
    /// The URL's behavior is inconsistent. It should always
    /// link to the app's custom settings in System Settings,
    /// but can sometimes just link to the root instead. The
    /// reason for this behavior is currently unknown.
    ///
    /// To improve this link behavior, add an empty Settings
    /// Bundle to your app. This will causes the app to more
    /// consistently open the correct System Settings screen.
    ///
    /// Maybe `appSettings` would be a better name, but this
    /// name was used to reduce the risk of naming conflicts
    /// with other URL extensions.
    static var systemSettings: URL? {
        #if os(iOS) || os(tvOS) || os(visionOS)
        URL(string: UIApplication.openSettingsURLString)
        #else
        nil
        #endif
    }
}

//
//  File.swift
//  
//
//  Created by Daniel Saidi on 2022-09-22.
//

import Foundation

public extension KeyboardInputViewController {

    /**
     Get the bundle ID of the currently active app.
     */
    @available(*, deprecated, message: "This no longer works in iOS 16 and will be removed in the next major version.")
    var activeAppBundleId: String? {
        if Bundle.main.isExtension {
            return parent?.value(forKey: "_hostBundleID") as? String
        } else {
            return Bundle.main.bundleIdentifier
        }
    }
}

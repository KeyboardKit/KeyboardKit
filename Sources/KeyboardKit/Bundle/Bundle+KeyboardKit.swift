//
//  Bundle+KeyboardKit.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-08-21.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import Foundation

extension Bundle {
    
    /// The main library bundle.
    static var library = Bundle.keyboardKit
}

extension Bundle {

    /// The name of the package bundle.
    ///
    /// This may change in any new Xcode version. If Xcode's
    /// name convention changes, you can print the path like
    /// this and look for the bundle name in the text:
    ///
    /// ```
    /// Bundle(for: BundleFinder.self)
    ///     .resourceURL?
    ///     .deletingLastPathComponent()
    ///     .deletingLastPathComponent()
    /// ```
    static let keyboardKitBundleName = "KeyboardKit_KeyboardKit"

    /// This bundle lets us use resources from KeyboardKit.
    ///
    /// We can't use .module, since KeyboardKit Pro is built
    /// from an Xcode Project.
    public static let keyboardKit: Bundle = {
        let candidates = [
            // Bundle should be present here when the package is linked into an App.
            Bundle.main.resourceURL,
            // Bundle should be present here when the package is linked into a framework.
            Bundle(for: BundleFinder.self).resourceURL,
            // For command-line tools.
            Bundle.main.bundleURL,
            // Bundle should be present here when running previews from a different package
            // (this is the path to "…/Debug-iphonesimulator/").
            Bundle(for: BundleFinder.self)
                .resourceURL?
                .deletingLastPathComponent()
                .deletingLastPathComponent()
                .deletingLastPathComponent(),
            Bundle(for: BundleFinder.self)
                .resourceURL?
                .deletingLastPathComponent()
                .deletingLastPathComponent()
        ]

        for candidate in candidates {
            let bundlePath = candidate?.appendingPathComponent(keyboardKitBundleName + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        
        return Bundle(for: BundleFinder.self)
    }()
}

private extension Bundle {

    class BundleFinder {}
}

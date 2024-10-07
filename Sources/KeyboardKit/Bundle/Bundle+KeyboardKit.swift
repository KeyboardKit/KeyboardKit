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
    static var library: Bundle { .keyboardKit }
}

public extension Bundle {

    /// The KeyboardKit bundle.
    ///
    /// We can't use .module, since KeyboardKit Pro is built
    /// from an Xcode Project.
    ///
    /// Inspiration:
    /// https://developer.apple.com/forums/thread/664295
    /// https://dev.jeremygale.com/swiftui-how-to-use-custom-fonts-and-images-in-a-swift-package-cl0k9bv52013h6bnvhw76alid 
    static let keyboardKit: Bundle = {
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

    /// The name of the KeyboardKit bundle.
    ///
    /// This may change in any new Xcode version, which will
    /// make any bundle resource usage fail.
    ///
    /// If this happens, you can print the bundle's path and
    /// look for the bundle name in the print output:
    ///
    /// ```
    /// Bundle(for: BundleFinder.self)
    ///     .resourceURL?
    ///     .deletingLastPathComponent()
    ///     .deletingLastPathComponent()
    /// ```
    static let keyboardKitBundleName = "KeyboardKit_KeyboardKit"
}

private extension Bundle {

    class BundleFinder {}
}

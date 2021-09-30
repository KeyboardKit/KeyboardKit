//
//  Bundle+Resources.swift
//  KeyboardKit
//
//  Created by Antoine Baché on 2021-01-23.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This file is explicitly excluded in `Package.swift`, but is
 used by CocoaPods, where the `module` bundle is not present.
 */
extension Bundle {
    
    /**
     This is the KeyboardKit library bundle.
     */
    static var module: Bundle = {
        Bundle(for: BundleToken.self)
    }()
}

private final class BundleToken {}

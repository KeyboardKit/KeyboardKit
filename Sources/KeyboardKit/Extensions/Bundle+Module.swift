//
//  Bundle+Resources.swift
//  KeyboardKit
//
//  Created by Antoine Baché on 2021-01-23.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

import Foundation

// This file is ignored when using SPM directly.

extension Bundle {
    static var module: Bundle = {
        Bundle(for: Token.self)
    }()
}

private final class Token {}

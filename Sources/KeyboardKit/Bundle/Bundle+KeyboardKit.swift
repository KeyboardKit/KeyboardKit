//
//  Bundle+KeyboardKit.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-08-21.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

extension Bundle {
    
    /// The main library bundle (for EmojiKit).
    static var library: Bundle { .keyboardKit }
}

public extension Bundle {

    /// The KeyboardKit bundle.
    ///
    /// KeyboardKit maps this bundle to the `.module` bundle,
    /// while KeyboardKit Pro must resolve it differently to
    /// handle how it's built with an Xcode Project.
    static var keyboardKit: Bundle { .module }
}

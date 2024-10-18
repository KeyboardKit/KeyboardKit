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
    /// KeyboardKit maps this to `.module` while KeyboardKit
    /// Pro needs to resolve it differently since it's built
    /// as an Xcode Project.
    static var keyboardKit: Bundle { .module }
}

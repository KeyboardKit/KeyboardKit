//
//  DemoLayoutProvider.swift
//  KeyboardCustom
//
//  Created by Daniel Saidi on 2022-09-02.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import Foundation
import KeyboardKit

/**
 This demo provider inherits the standard provider and makes
 it replace the alphabetic input keys with Unicode keys.

 ``KeyboardViewController`` registers this class to show you
 how you can set up a custom layout provider.
 */
class DemoLayoutProvider: StandardKeyboardLayoutProvider {
    
    init() {
        super.init(
            baseProvider: EnglishKeyboardLayoutProvider(
                alphabeticInputSet: .unicodeDemo
            )
        )
    }
}

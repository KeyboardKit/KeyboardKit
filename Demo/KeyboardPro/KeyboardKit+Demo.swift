//
//  KeyboardKit+Demo.swift
//  KeyboardPro
//
//  Created by Daniel Saidi on 2022-02-07.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
//

import Foundation
import KeyboardKitPro

extension KeyboardAction {
    
    static let rocket = character("🚀")
}

extension KeyboardFeedback.Audio {
 
    static let rocketFuse = customUrl(
        Bundle.main.url(forResource: "fuse", withExtension: "wav")
    )
    
    static let rocketLaunch = customId(1303)
}

//
//  KeyboardSetting.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-03-14.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Foundation

public enum KeyboardSetting: String {
    
    case
    currentPageIndex
}


// MARK: - Properties

public extension KeyboardSetting {
    
    public var name: String {
        return "com.danielsaidi.keyboardKit.settings.\(rawValue)"
    }
}

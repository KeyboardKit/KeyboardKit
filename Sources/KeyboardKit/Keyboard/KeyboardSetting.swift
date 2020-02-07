//
//  KeyboardSetting.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-03-14.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum represents some sttings that can be stored in the
 user device's persistent memory.
*/
public enum KeyboardSetting: String {
    
    case
    currentPageIndex
}

public extension KeyboardSetting {
    
    var key: String {
        return "com.keyboardKit.settings.\(rawValue)"
    }
    
    func key(for id: String) -> String {
        return "\(key).\(id)"
    }
}

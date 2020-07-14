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
 
 If you want to persist the value of a setting anywhere, you
 can use the `key` property. If multiple keyboard components
 can share settings, you can use `key(for:)` to get a unique
 setting key for each component.
*/
public enum KeyboardSetting {
    
    /**
     This key can be used to persist the current page of any
     multi-paged keyboard.
     */
    case currentPageIndex
    
    /**
     This key can be used for any custom setting that is not
     yet in the fixed list of settings.
     */
    case custom(name: String)
}

public extension KeyboardSetting {
    
    var key: String { "\(keyPrefix)\(name)" }
    
    func key(for id: String) -> String { "\(key).\(id)" }
        
    var name: String {
        switch self {
        case .currentPageIndex: return "currentPageIndex"
        case .custom(let name): return name
        }
    }
}

private extension KeyboardSetting {
    
    var keyPrefix: String { "com.keyboardKit.settings." }
}

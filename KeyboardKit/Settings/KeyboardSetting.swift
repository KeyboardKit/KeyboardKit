//
//  KeyboardSetting.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-03-14.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 The keyboard settings enum is just a representation of some
 general keyboard properties that may be a good idea to save
 in persistent memory.
 
 */

import Foundation

public enum KeyboardSetting: String {
    
    case
    currentPageIndex
}

public extension KeyboardSetting {
    
    var key: String {
        return "com.keyboardKit.settings.\(rawValue)"
    }
    
//    func key(for presenter: KeyboardPresenter) -> String {
//        guard let id = presenter.id else { return key }
//        return "\(key).\(id)"
//    }
}

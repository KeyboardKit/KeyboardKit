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
    
    var key: String {
        return "com.keyboardKit.settings.\(rawValue)"
    }
    
    func key(for presenter: KeyboardPresenter) -> String {
        guard let id = presenter.id else { return key }
        return "\(key).\(id)"
    }
}

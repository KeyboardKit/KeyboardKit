//
//  StandardKeyboardSettings.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-25.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This is the standard settings that is used by KeyboardKit's
 keyboard view controllers. It uses user defaults to persist
 settings changes.
 
 */

import Foundation

open class StandardKeyboardSettings: KeyboardSettings {
    
    public func getCurrentPageIndex(for presenter: KeyboardPresenter) -> Int {
        let key = self.key(for: .currentPageIndex, in: presenter)
        return defaults.integer(forKey: key)
    }
    
    public func setCurrentPageIndex(_ index: Int, for presenter: KeyboardPresenter) {
        let key = self.key(for: .currentPageIndex, in: presenter)
        defaults.set(index, forKey: key)
        defaults.synchronize()
    }
}

private extension StandardKeyboardSettings {
    
    var defaults: UserDefaults {
        return .standard
    }
    
    func key(for setting: KeyboardSetting, in presenter: KeyboardPresenter) -> String {
        return setting.key(for: presenter)
    }
}

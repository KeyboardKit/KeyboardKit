//
//  KeyboardSettings.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-25.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This protocol can be implemented by any class that could be
 used to get and persist common keyboard settings. Keyboards
 will use user defaults by default, but this is customizable.
 
 */

import Foundation

public protocol KeyboardSettings {

    func getCurrentPageIndex(for presenter: KeyboardPresenter) -> Int
    func setCurrentPageIndex(_ index: Int, for presenter: KeyboardPresenter)
}

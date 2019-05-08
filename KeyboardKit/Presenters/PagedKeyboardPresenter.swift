//
//  PagedKeyboardPresenter.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-23.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This protocol can be implemented by any class that presents
 a keyboard over multiple pages. It provides default ways to
 persist and restore page index, using user defaults.
 
 When inheriting this protocol, you should make sure to call
 `persistCurrentPageIndex` when the page index changes, then
 call `restoreLastPageIndex()` when the keyboard size and/or
 setup changes.
 
 */

import UIKit

public protocol PagedKeyboardPresenter: AnyObject {

    var id: String { get }
    
    var canPersistPageIndex: Bool { get }
    var canRestorePageIndex: Bool { get }
    var currentPageIndex: Int { get set }
    var numberOfPages: Int { get }
}

public extension PagedKeyboardPresenter {
    
    private var settingsKey: String {
        return KeyboardSetting.currentPageIndex.key(for: id)
    }
    
    func persistCurrentPageIndex() {
        guard canPersistPageIndex else { return }
        UserDefaults.standard.set(currentPageIndex, forKey: settingsKey)
    }
    
    func restoreCurrentPageIndex() {
        guard canRestorePageIndex else { return }
        let index = UserDefaults.standard.integer(forKey: settingsKey)
        guard index != currentPageIndex else { return }
        guard index < numberOfPages else { return }
        currentPageIndex = index
    }
}

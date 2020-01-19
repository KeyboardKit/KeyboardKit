//
//  PagedKeyboardPresenter.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-23.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This protocol can be implemented by any class that presents
 a keyboard over multiple pages. It provides ways to persist
 and restore page index, using user defaults.
 */
public protocol PagedKeyboardComponent: UIView {

    var id: String { get }
    
    var canPersistPageIndex: Bool { get }
    var canRestorePageIndex: Bool { get }
    var currentPageIndex: Int { get set }
    var numberOfPages: Int { get }
}

extension PagedKeyboardComponent {
    
    var settingsKey: String {
        KeyboardSetting.currentPageIndex.key(for: id)
    }
}

public extension PagedKeyboardComponent {
    
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

//
//  UIPagedKeyboardComponent.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-23.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This protocol can be implemented by any class that presents
 keyboard content over multiple pages, e.g. an emoji keboard.
 
 It provides ways to persist page index, using user defaults.
 */
public protocol UIPagedKeyboardComponent: UIView {

    var id: String { get }
    
    var canPersistPageIndex: Bool { get }
    var canRestorePageIndex: Bool { get }
    var currentPageIndex: Int { get set }
    var numberOfPages: Int { get }
}

extension UIPagedKeyboardComponent {
    
    var settingsKey: String { "com.keyboardkit.UIPagedKeyboardComponent.\(id).currentpage" }
}

public extension UIPagedKeyboardComponent {
    
    var persistedCurrentPageIndex: Int {
        defaults.integer(forKey: settingsKey)
    }
    
    func persistCurrentPageIndex() {
        guard canPersistPageIndex else { return }
        defaults.set(currentPageIndex, forKey: settingsKey)
    }
    
    func restoreCurrentPageIndex() {
        guard canRestorePageIndex else { return }
        let index = defaults.integer(forKey: settingsKey)
        guard index != currentPageIndex else { return }
        guard index < numberOfPages else { return }
        currentPageIndex = index
    }
}

private extension UIPagedKeyboardComponent {
    
    var defaults: UserDefaults { .standard }
}

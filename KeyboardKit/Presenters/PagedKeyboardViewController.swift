//
//  PagedKeyboardViewController.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-23.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This protocol can be implemented by multipage keyboard view
 controllers. Any class that implements it get page-specific
 functionality for free.
 
 When inheriting this protocol, you should make sure to call
 `restoreLastPageIndex()` in `viewDidLayoutSubviews` as well
 as anytime the keyboard size and page may have changes. You
 should also call `persistCurrentPageIndex` anytime the page
 index changes.
 
 */

import UIKit

public protocol PagedKeyboardViewController: KeyboardViewController {

    var canRestoreLastPageIndex: Bool { get }
    var currentPageIndex: Int { get set }
    var keyboardButtonsPerPage: Int { get }
    var numberOfPages: Int { get }
}

public extension PagedKeyboardViewController {
    
    func restoreLastPageIndex() {
        guard canRestoreLastPageIndex else { return }
        let index = settings.getCurrentPageIndex(for: keyboardPresenter)
        let maxIndex = numberOfPages - 1
        currentPageIndex = index.limit(min: 0, max: maxIndex)
    }
}

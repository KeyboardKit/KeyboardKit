//
//  UIScrollView+PageNumber.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-01.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIScrollView {

    /**
     Get and set the current page index by using the content
     offset as source of truth.
     */
    var currentPageIndex: Int {
        get { return Int((contentOffset.x + 10) / frame.size.width) }
        set { contentOffset.x = frame.size.width * CGFloat(newValue) }
    }
}

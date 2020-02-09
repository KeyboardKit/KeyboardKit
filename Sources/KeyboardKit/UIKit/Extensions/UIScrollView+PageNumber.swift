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
     Get/set the current page index using the content offset.
     */
    var currentPageIndex: Int {
        get { return Int((contentOffset.x + 10) / frame.size.width) }
        set { contentOffset.x = frame.size.width * CGFloat(newValue) }
    }
}

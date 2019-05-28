//
//  UIScrollView+PageNumber.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-01.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This `UIScrollView` extension can get/set the "current page
 index" of horizontally paged scroll views, by modifying the
 content offset.
 
 */

import UIKit

public extension UIScrollView {

    var currentPageIndex: Int {
        get { return Int((contentOffset.x + 10) / frame.size.width) }
        set { contentOffset.x = frame.size.width * CGFloat(newValue) }
    }
}

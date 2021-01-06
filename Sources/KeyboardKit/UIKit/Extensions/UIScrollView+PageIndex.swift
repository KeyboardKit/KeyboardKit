//
//  UIScrollView+PageIndex.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIScrollView {

    /**
     Get/set the current page index using the content offset.
     */
    var currentPageIndex: Int {
        get { width < renderingAdjustment ? 0 : Int(adjustedRatio) }
        set { contentOffset.x = width * CGFloat(newValue) }
    }
}

private extension UIScrollView {
    
    var adjustedRatio: CGFloat { renderingAdjustedOffset / denominator }
    var denominator: CGFloat { max(width, 1) }
    var offset: CGFloat { contentOffset.x }
    var renderingAdjustedOffset: CGFloat { offset + renderingAdjustment }
    var renderingAdjustment: CGFloat { 10 }
    var width: CGFloat { frame.size.width }
}

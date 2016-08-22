//
//  UIScrollView_PageNumber.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2016-01-04.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIScrollView {

    public var pageNumber : Int {
        get { return Int(contentOffset.x / frame.size.width) }
        set { contentOffset.x = frame.size.width * CGFloat(newValue) }
    }
}

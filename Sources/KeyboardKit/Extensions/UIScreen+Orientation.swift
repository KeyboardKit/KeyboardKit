//
//  UIScreen+Orientation.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-05-05.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

extension UIScreen {
    
    /**
     Get the current screen orientation. This is required by
     input view controllers, since an extensions can't check
     the application's status bar style.
     */
    var orientation: UIInterfaceOrientation {
        let point = coordinateSpace.convert(CGPoint.zero, to: fixedCoordinateSpace)
        switch (point.x, point.y) {
        case (0, 0): return .portrait
        case let (x, y) where x != 0 && y != 0: return .portraitUpsideDown
        case let (0, y) where y != 0: return .landscapeLeft
        case let (x, 0) where x != 0: return .landscapeRight
        default: return .unknown
        }
    }
}

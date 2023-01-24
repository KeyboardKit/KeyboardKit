//
//  InterfaceOrientationResolver.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-05.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

#if canImport(UIKit)
import UIKit
#endif

/**
 This protocol can be implemented by any types that can find
 out the current interface orientation.

 This protocol is implemented by `UIScreen` in `UIKit`.
 */
protocol InterfaceOrientationResolver {

    /**
     Get the current interface orientation
     */
    var interfaceOrientation: InterfaceOrientation { get }
}


// MARK: - UIScreen

#if os(iOS) || os(tvOS)
extension UIScreen: InterfaceOrientationResolver {}

extension UIScreen {

    /**
     Get the current interface orientation.

     This is required since keyboard extensions cannot check
     the status bar style of the application.
     */
    var interfaceOrientation: InterfaceOrientation {
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
#endif

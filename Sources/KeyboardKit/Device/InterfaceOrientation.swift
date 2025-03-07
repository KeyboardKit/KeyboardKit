//
//  InterfaceOrientation.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-05.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import Foundation

#if canImport(UIKit)
import UIKit
#endif

/// This enum defines supported interface orientations.
///
/// The static ``current`` property will resolve the current
/// interface orientation.
public enum InterfaceOrientation: String, CaseIterable, KeyboardModel {

    case portrait
    case portraitUpsideDown
    case landscape
    case landscapeLeft
    case landscapeRight
    case unknown
}

public extension InterfaceOrientation {

    /// Get the current interface orientation.
    static var current: InterfaceOrientation {
        #if os(iOS) || os(tvOS)
        UIScreen.main.interfaceOrientation
        #elseif os(macOS)
        .landscape
        #elseif os(watchOS)
        .portrait
        #else
        .unknown
        #endif
    }

    /// Whether or not the orientation is landscape.
    var isLandscape: Bool {
        switch self {
        case .portrait, .portraitUpsideDown: false
        case .landscape, .landscapeLeft, .landscapeRight: true
        case .unknown: false
        }
    }

    /// Whether or not the orientation is portrait.
    var isPortrait: Bool {
        switch self {
        case .portrait, .portraitUpsideDown: true
        case .landscape, .landscapeLeft, .landscapeRight: false
        case .unknown: false
        }
    }
}

#if os(iOS) || os(tvOS)
extension UIScreen {

    /// Get the current interface orientation.
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

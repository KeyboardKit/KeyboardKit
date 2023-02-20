//
//  InterfaceOrientation.swift
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
 This enum can be used to specify an interface orientation.

 The static ``current`` property will resolve to the current
 interface orientation.
 */
public enum InterfaceOrientation: String, CaseIterable, Equatable {

    case portrait, portraitUpsideDown, landscape, landscapeLeft, landscapeRight, unknown
}

public extension InterfaceOrientation {

    /**
     Get the current interface orientation.
     */
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

    /**
     Whether or not the orientation is a portrait one.
     */
    var isLandscape: Bool {
        switch self {
        case .portrait, .portraitUpsideDown: return false
        case .landscape, .landscapeLeft, .landscapeRight: return true
        case .unknown: return false
        }
    }

    /**
     Whether or not the orientation is a portrait one.
     */
    var isPortrait: Bool {
        switch self {
        case .portrait, .portraitUpsideDown: return true
        case .landscape, .landscapeLeft, .landscapeRight: return false
        case .unknown: return false
        }
    }
}

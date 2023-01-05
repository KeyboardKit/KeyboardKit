//
//  InterfaceOrientation.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-05.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
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

    case portrait, portraitUpsideDown, landscapeLeft, landscapeRight, unknown
}

public extension InterfaceOrientation {

    /**
     Get the current interface orientation.
     */
    static var current: InterfaceOrientation {
        #if os(iOS)
        UIScreen.main.interfaceOrientation
        #else
        .portrait
        #endif
    }

    /**
     Whether or not the orientation is a portrait one.
     */
    var isLandscape: Bool {
        self == .landscapeLeft || self == .landscapeRight
    }

    /**
     Whether or not the orientation is a portrait one.
     */
    var isPortrait: Bool {
        self == .portrait || self == .portraitUpsideDown
    }
}

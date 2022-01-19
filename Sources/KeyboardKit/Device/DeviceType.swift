//
//  DeviceType.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-01-19.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import Foundation

#if canImport(UIKit)
import UIKit
#endif

/**
 This enum can be used to specify the type of device without
 having to have access to the actual device type.
 
 The static ``current`` property will resolve to the current
 device type.
 */
public enum DeviceType: Equatable {
    
    case phone, pad, watch, mac, tv, other
}

public extension DeviceType {
    
    /**
     Get the current device type.
     */
    static var current: DeviceType {
        #if os(iOS)
        UIDevice.current.isPad ? .pad : .phone
        #elseif os(macOS)
        .mac
        #elseif os(tvOS)
        .tv
        #elseif os(watchOS)
        .watch
        #else
        .other
        #endif
    }
}

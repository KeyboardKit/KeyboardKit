//
//  DeviceType.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-01-19.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
//

import Foundation

#if canImport(UIKit)
import UIKit
#endif

/// This enum defines various supported device types.
///
/// The static ``current`` property will resolve the current
/// device type.
public enum DeviceType: String, CaseIterable, Equatable {
    
    case phone, pad, watch, mac, tv, vision, other
}

public extension DeviceType {
    
    var isMac: Bool { self == .mac }
    var isPad: Bool { self == .pad }
    var isPhone: Bool { self == .phone }
    var isTv: Bool { self == .tv }
    var isWatch: Bool { self == .watch }
    var isVisionPro: Bool { self == .vision }
}

public extension DeviceType {
    
    /// Get the current device type.
    static var current: DeviceType {
        #if os(iOS)
        UIDevice.current.userInterfaceIdiom == .pad ? .pad : .phone
        #elseif os(macOS)
        .mac
        #elseif os(tvOS)
        .tv
        #elseif os(watchOS)
        .watch
        #elseif os(visionOS)
        .vision
        #else
        .other
        #endif
    }
}

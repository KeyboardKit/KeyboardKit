//
//  KeyboardLayoutServiceProxy.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-16.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This protocol is used to let device-based services share
/// behavior, when basing a layout on different device types.
///
/// The protocol is currently only used by localized service
/// implementations in KeyboardKit Pro.
public protocol KeyboardLayoutServiceProxy: KeyboardLayoutService {

    /// The layout service to use for iPad devices.
    var iPadService: KeyboardLayoutService { get }

    /// The layout service to use for iPad devices.
    var iPhoneService: KeyboardLayoutService { get }
}

public extension KeyboardLayoutServiceProxy {

    /// The layout service to use for the provided context.
    func keyboardLayoutService(
        for context: KeyboardContext
    ) -> KeyboardLayoutService {
        switch context.deviceType {
        case .phone: iPhoneService
        case .pad: iPadService
        default: iPhoneService
        }
    }
}

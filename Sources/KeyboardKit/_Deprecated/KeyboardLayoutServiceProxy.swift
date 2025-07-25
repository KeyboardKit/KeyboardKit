//
//  KeyboardLayoutServiceProxy.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-16.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import Foundation

/// > Deprecated: This protocol will be removed in 10.0. Use
/// the new `.keyboardLayout` view modifier instead.
///
/// This protocol is used to let device-based services share
/// behavior, when basing a layout on different device types.
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
        switch context.deviceTypeForKeyboard {
        case .phone: iPhoneService
        case .pad: iPadService
        default: iPhoneService
        }
    }
}

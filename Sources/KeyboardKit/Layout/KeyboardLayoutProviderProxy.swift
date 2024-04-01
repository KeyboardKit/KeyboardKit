//
//  KeyboardLayoutProviderProxy.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-16.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This protocol is a help protocol that makes device-based
/// layout providers share behavior when basing their layout
/// on different device types.
///
/// The protocol is currently only used by localized service
/// implementations in KeyboardKit Pro.
public protocol KeyboardLayoutProviderProxy: KeyboardLayoutProvider {
    
    /// The layout provider to use for iPad devices.
    var iPadProvider: KeyboardLayoutProvider { get }

    /// The layout provider to use for iPad devices.
    var iPhoneProvider: KeyboardLayoutProvider { get }
}

public extension KeyboardLayoutProviderProxy {
    
    /// The keyboard layout provider to use for the context.
    func keyboardLayoutProvider(
        for context: KeyboardContext
    ) -> KeyboardLayoutProvider {
        switch context.deviceType {
        case .phone: iPhoneProvider
        case .pad: iPadProvider
        default: iPhoneProvider
        }
    }
}

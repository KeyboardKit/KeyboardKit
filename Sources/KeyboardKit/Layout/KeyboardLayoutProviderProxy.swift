//
//  DeviceKeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-16.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol extends ``KeyboardLayoutProvider`` and lets a
 provider resolve layouts with different providers.

 For now, the protocol lets you switch provider based on the
 current device type.
 */
public protocol KeyboardLayoutProviderProxy: KeyboardLayoutProvider {
    
    /// The layout provider to use for iPad devices.
    var iPadProvider: KeyboardLayoutProvider { get }

    /// The layout provider to use for iPad devices.
    var iPhoneProvider: KeyboardLayoutProvider { get }
}

public extension KeyboardLayoutProviderProxy {
    
    /// The keyboard layout provider to use for the context.
    func keyboardLayoutProvider(for context: KeyboardContext) -> KeyboardLayoutProvider {
        switch context.deviceType {
        case .phone: return iPhoneProvider
        case .pad: return iPadProvider
        default: return iPhoneProvider
        }
    }
}

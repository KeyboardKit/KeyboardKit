//
//  KeyboardLayoutProviderProxy.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-16.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation

@available(*, deprecated, message: "This is no longer used.")
public protocol KeyboardLayoutProviderProxy: KeyboardLayoutProvider {
    
    /// The layout provider to use for iPad devices.
    var iPadProvider: KeyboardLayoutProvider { get }

    /// The layout provider to use for iPad devices.
    var iPhoneProvider: KeyboardLayoutProvider { get }
}

@available(*, deprecated, message: "This is no longer used.")
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

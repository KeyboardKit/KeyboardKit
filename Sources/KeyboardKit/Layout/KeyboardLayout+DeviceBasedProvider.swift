//
//  KeyboardLayout+DeviceBasedProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-12-29.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import Foundation

extension KeyboardLayout {
    
    /// This base class provides a foundation for generating
    /// layouts that are based on an ``InputSet`` and device.
    ///
    /// This class will use either the ``iPhoneProvider`` or
    /// ``iPadProvider``, based on the current device that's
    /// specified by the ``KeyboardContext/deviceType``.
    ///
    /// You can inherit this class to get base functionality,
    /// then override any open parts that you want to change.
    ///
    /// See <doc:Layout-Article> for more information.
    open class DeviceBasedProvider: KeyboardLayout.BaseProvider, LocalizedService {
        
        /// Create an device-based keyboard layout provider.
        ///
        /// - Parameters:
        ///   - alphabeticInputSet: The alphabetic input set to use, by default ``InputSet/qwerty``.
        ///   - numericInputSet: The numeric input set to use, by default ``InputSet/numeric(currency:)``.
        ///   - symbolicInputSet: The symbolic input set to use, by default ``InputSet/symbolic(currencies:)``.
        public override init(
            alphabeticInputSet: InputSet = .qwerty,
            numericInputSet: InputSet = .numeric(currency: "$"),
            symbolicInputSet: InputSet = .symbolic(currencies: ["€", "£", "¥"])
        ) {
            super.init(
                alphabeticInputSet: alphabeticInputSet,
                numericInputSet: numericInputSet,
                symbolicInputSet: symbolicInputSet
            )
        }
        
        /// The locale identifier.
        public var localeKey = KeyboardLocale.english.id
        
        /// The layout provider to use for iPad devices.
        public lazy var iPadProvider: KeyboardLayoutProvider = KeyboardLayout.iPadProvider(
            alphabeticInputSet: alphabeticInputSet,
            numericInputSet: numericInputSet,
            symbolicInputSet: symbolicInputSet
        )
        
        /// The layout provider to use for iPhone devices.
        public lazy var iPhoneProvider: KeyboardLayoutProvider = KeyboardLayout.iPhoneProvider(
            alphabeticInputSet: alphabeticInputSet,
            numericInputSet: numericInputSet,
            symbolicInputSet: symbolicInputSet
        )
        
        /// The layout to use for the provided context.
        open override func keyboardLayout(
            for context: KeyboardContext
        ) -> KeyboardLayout {
            let provider = keyboardLayoutProvider(for: context)
            let layout = provider.keyboardLayout(for: context)
            return layout
        }
        
        /// The provider to use for the provided context.
        open func keyboardLayoutProvider(
            for context: KeyboardContext
        ) -> KeyboardLayoutProvider {
            switch context.deviceType {
            case .phone: iPhoneProvider
            case .pad: iPadProvider
            default: iPhoneProvider
            }
        }
    }
}

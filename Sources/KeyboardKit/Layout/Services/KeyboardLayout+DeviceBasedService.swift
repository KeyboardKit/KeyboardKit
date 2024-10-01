//
//  KeyboardLayout+DeviceBasedService.swift
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
    /// The class will either use an ``iPhoneService`` or an
    /// ``iPadService``, based on the current device that is
    /// specified by the ``KeyboardContext/deviceType``.
    ///
    /// You can inherit this class to get base functionality,
    /// then override any open parts that you want to change.
    ///
    /// See <doc:Layout-Article> for more information.
    open class DeviceBasedService: KeyboardLayout.BaseService, LocalizedService {

        /// Create an device-based keyboard layout service.
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
        
        /// The layout service to use for iPad devices.
        public lazy var iPadService: KeyboardLayoutService = KeyboardLayout.iPadService(
            alphabeticInputSet: alphabeticInputSet,
            numericInputSet: numericInputSet,
            symbolicInputSet: symbolicInputSet
        )
        
        /// The layout service to use for iPhone devices.
        public lazy var iPhoneService: KeyboardLayoutService = KeyboardLayout.iPhoneService(
            alphabeticInputSet: alphabeticInputSet,
            numericInputSet: numericInputSet,
            symbolicInputSet: symbolicInputSet
        )
        
        /// The layout to use for the provided context.
        open override func keyboardLayout(
            for context: KeyboardContext
        ) -> KeyboardLayout {
            let service = keyboardLayoutService(for: context)
            let layout = service.keyboardLayout(for: context)
            return layout
        }
        
        /// The layout service to use for a certain context.
        open func keyboardLayoutService(
            for context: KeyboardContext
        ) -> KeyboardLayoutService {
            switch context.deviceType {
            case .phone: iPhoneService
            case .pad: iPadService
            default: iPhoneService
            }
        }
    }
}

//
//  KeyboardLayout+DeviceBasedLayoutService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-12-29.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
//

import Foundation

extension KeyboardLayout {

    /// > Deprecated: These services will be removed in 10.0.
    ///
    /// This base class provides a foundation for generating
    /// layouts based on an ``KeyboardLayout/InputSet``, and
    /// a secific device type.
    open class DeviceBasedLayoutService: KeyboardLayout.BaseLayoutService, LocalizedService {

        /// Create an device-based keyboard layout service.
        ///
        /// - Parameters:
        ///   - alphabeticInputSet: The alphabetic input set to use, by default ``KeyboardLayout/InputSet/qwerty``.
        ///   - numericInputSet: The numeric input set to use, by default ``KeyboardLayout/InputSet/numeric``.
        ///   - symbolicInputSet: The symbolic input set to use, by default ``KeyboardLayout/InputSet/symbolic``.
        public override init(
            alphabeticInputSet: InputSet = .qwerty,
            numericInputSet: InputSet = .numeric,
            symbolicInputSet: InputSet = .symbolic
        ) {
            super.init(
                alphabeticInputSet: alphabeticInputSet,
                numericInputSet: numericInputSet,
                symbolicInputSet: symbolicInputSet
            )
        }
        
        /// The locale identifier.
        public var localeKey = Locale.english.identifier
        
        /// The layout service to use for iPad devices.
        public lazy var iPadService: KeyboardLayoutService = KeyboardLayout.iPadLayoutService(
            alphabeticInputSet: alphabeticInputSet,
            numericInputSet: numericInputSet,
            symbolicInputSet: symbolicInputSet
        )
        
        /// The layout service to use for iPhone devices.
        public lazy var iPhoneService: KeyboardLayoutService = KeyboardLayout.iPhoneLayoutService(
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
            switch context.deviceTypeForKeyboard {
            case .phone: iPhoneService
            case .pad: iPadService
            default: iPhoneService
            }
        }
    }
}

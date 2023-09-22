//
//  InputSetBasedKeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-12-29.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This layout provider maps the provided input sets to device
 specific keyboard layouts.
 
 The provider returns layouts with the same configuration as
 standard QWERTY keyboards. This is a layout that is used by
 many native keyboards, e.g. English.
 
 If any of the provided input sets has a different amount of
 items than the default input sets, you must create a custom
 layout provider if you want to adjust the layout.
 */
open class InputSetBasedKeyboardLayoutProvider: BaseKeyboardLayoutProvider, KeyboardLayoutProviderProxy, LocalizedService {

    /**
     Create an input set-based keyboard layout provider.
     
     - Parameters:
       - alphabeticInputSet: The alphabetic input set to use, by default ``InputSet/qwerty``.
       - numericInputSet: The numeric input set to use, by default ``InputSet/standardNumeric(currency:)``.
       - symbolicInputSet: The symbolic input set to use, by default ``InputSet/standardSymbolic(currencies:)``.
     */
    public override init(
        alphabeticInputSet: InputSet = .qwerty,
        numericInputSet: InputSet = .standardNumeric(currency: "$"),
        symbolicInputSet: InputSet = .standardSymbolic(currencies: "€£¥".chars)
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
    public lazy var iPadProvider: KeyboardLayoutProvider = iPadKeyboardLayoutProvider(
        alphabeticInputSet: alphabeticInputSet,
        numericInputSet: numericInputSet,
        symbolicInputSet: symbolicInputSet
    )

    /// The layout provider to use for iPhone devices.
    public lazy var iPhoneProvider: KeyboardLayoutProvider = iPhoneKeyboardLayoutProvider(
        alphabeticInputSet: alphabeticInputSet,
        numericInputSet: numericInputSet,
        symbolicInputSet: symbolicInputSet
    )

    /// The layout keyboard to use for the provided context.
    open override func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        keyboardLayoutProvider(for: context)
            .keyboardLayout(for: context)
    }
}

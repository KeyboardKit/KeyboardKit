//
//  InputSetBasedKeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-12-29.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This layout provider provides ``InputSet``-based layouts.
///
/// The provider will generate a layout that is based on the
/// input sets you inject, using either the ``iPhoneProvider``
/// or ``iPadProvider``. It will use the provided context to
/// determine things like keyboard type and current platform.
///
/// You can inherit this provider and customize it as needed.
open class InputSetBasedKeyboardLayoutProvider: BaseKeyboardLayoutProvider, KeyboardLayoutProviderProxy, LocalizedService {

    /// Create an input set-based keyboard layout provider.
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
    open override func keyboardLayout(
        for context: KeyboardContext
    ) -> KeyboardLayout {
        let provider = keyboardLayoutProvider(for: context)
        let layout = provider.keyboardLayout(for: context)
        return layout
    }
}

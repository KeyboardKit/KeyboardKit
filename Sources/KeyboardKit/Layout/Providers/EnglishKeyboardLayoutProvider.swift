//
//  EnglishKeyboardLayoutProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-12-29.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This keyboard layout provider implementation can be used to
 create standard English keyboard layouts.
 */
open class EnglishKeyboardLayoutProvider: SystemKeyboardLayoutProvider, KeyboardLayoutProviderProxy, LocalizedService {

    /**
     Create an English keyboard layout provider.
     */
    public override init(
        alphabeticInputSet: AlphabeticInputSet = .english,
        numericInputSet: NumericInputSet = .englishNumeric,
        symbolicInputSet: SymbolicInputSet = .englishSymbolic
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

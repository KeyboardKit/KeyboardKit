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

     - Parameters:
       - inputSetProvider: The input set provider to use, by default ``EnglishInputSetProvider``.
     */
    public override init(
        inputSetProvider: InputSetProvider = EnglishInputSetProvider()
    ) {
        super.init(inputSetProvider: inputSetProvider)
    }

    /**
     The locale identifier.
     */
    public let localeKey: String = KeyboardLocale.english.id

    /**
     The layout provider to use for iPad devices.
     */
    public lazy var iPadProvider = iPadKeyboardLayoutProvider(
        inputSetProvider: inputSetProvider
    )

    /**
     The layout provider to use for iPhone devices.
     */
    public lazy var iPhoneProvider = iPhoneKeyboardLayoutProvider(
        inputSetProvider: inputSetProvider
    )

    /**
     The layout keyboard to use for a given keyboard context.
     */
    open override func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        keyboardLayoutProvider(for: context)
            .keyboardLayout(for: context)
    }

    /**
     The keyboard layout provider to use for a given context.
     */
    open func keyboardLayoutProvider(for context: KeyboardContext) -> KeyboardLayoutProvider {
        switch context.deviceType {
        case .phone: return iPhoneProvider
        case .pad: return iPadProvider
        default: return iPhoneProvider
        }
    }
}

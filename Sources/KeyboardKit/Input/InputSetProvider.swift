//
//  InputSetProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any classes that can be
 used to provide ``InputSet`` values for keyboard layouts.
 
 KeyboardKit will create a ``StandardInputSetProvider`` when
 the keyboard extension is started, then apply that instance
 to ``KeyboardInputViewController/inputSetProvider`` and use
 this instance by default to generate input sets.
 
 KeyboardKit comes with a ``StandardInputSetProvider`` class,
 which can be initialized with a list of localized providers.
 It also has an ``EnglishInputSetProvider`` that defines the
 alphabetic, numeric and symbolic inputs for U.S. English.
 
 KeyboardKit Pro can be used to unlock an input set provider
 for each ``KeyboardLocale``. This means that you can create
 a completely localized ``SystemKeyboard`` for all available
 locales with just a single line of code.
 
 If you don't have a KeyboardKit Pro license, you can create
 a custom input set provider.
 
 You can create a custom implementation of this protocol, by
 either inheriting and customizing the standard class (which
 gives you a lot of functionality for free) or by creating a
 new implementation from scratch. When you're implementation
 is ready, just replace the controller service with your own
 implementation to make the library use it instead.
 */
public protocol InputSetProvider: AnyObject {
    
    /**
     The input set to use for alphabetic keyboards.
     */
    var alphabeticInputSet: AlphabeticInputSet { get }

    /**
     The input set to use for numeric keyboards.
     */
    var numericInputSet: NumericInputSet { get }

    /**
     The input set to use for symbolic keyboards.
     */
    var symbolicInputSet: SymbolicInputSet { get }
}

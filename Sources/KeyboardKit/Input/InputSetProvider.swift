//
//  InputSetProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any classes that can be
 used to provide various ``InputSet`` values.
 
 KeyboardKit will create a ``StandardInputSetProvider`` when
 the keyboard extension is started, then apply that instance
 to ``KeyboardInputViewController/inputSetProvider`` and use
 it by default when generating input sets.
 
 KeyboardKit Pro can be used to unlock a unique provider for
 every ``KeyboardLocale``, which means that you can create a
 fully localized ``SystemKeyboard`` for all keyboard locales
 with just a single line of code.
 
 You can create a custom implementation of this protocol, by
 inheriting and customizing the standard class or creating a
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
